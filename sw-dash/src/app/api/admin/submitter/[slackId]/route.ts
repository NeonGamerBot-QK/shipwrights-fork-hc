import { NextResponse } from 'next/server'
import { prisma } from '@/lib/db'
import { PERMS } from '@/lib/perms'
import { getSlackUser } from '@/lib/slack'
import { withParams } from '@/lib/api'

export const GET = withParams<{ slackId: string }>(PERMS.submitter_edit)(async ({ params }) => {
  const { slackId } = params

  const [slackProfile, notes, tickets] = await Promise.all([
    getSlackUser(slackId).catch(() => null),
    prisma.ftSubmitterNote.findMany({
      where: { slackId },
      include: {
        staff: { select: { id: true, username: true, avatar: true, slackId: true, role: true } },
      },
      orderBy: { createdAt: 'desc' },
    }),
    prisma.ticket.findMany({
      where: { userId: slackId },
      select: { id: true, status: true, createdAt: true },
      orderBy: { createdAt: 'desc' },
    }),
  ])

  return NextResponse.json({
    profile: slackProfile
      ? {
          name: slackProfile.profile?.display_name || slackProfile.real_name || slackProfile.name,
          avatar: slackProfile.profile?.image_72,
          slackId,
        }
      : { name: null, avatar: null, slackId },
    notes: notes.map((n) => ({
      id: n.id,
      text: n.text,
      certId: n.certId,
      ticketId: n.ticketId,
      createdAt: n.createdAt,
      staff: n.staff.username,
      staffSlackId: n.staff.slackId,
      staffRole: n.staff.role,
      staffAvatar: n.staff.avatar,
    })),
    tickets,
  })
})
