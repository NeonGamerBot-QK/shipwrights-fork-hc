import { NextResponse } from 'next/server'
import { prisma } from '@/lib/db'
import { PERMS } from '@/lib/perms'
import { log } from '@/lib/log'
import { withParams } from '@/lib/api'

export const POST = withParams<{ slackId: string }>(PERMS.submitter_edit)(async ({
  user,
  req,
  params,
  ip,
  ua,
}) => {
  const { slackId } = params
  const { text, certId, ticketId } = await req.json()

  if (!text?.trim()) {
    return NextResponse.json({ error: 'note cant be empty' }, { status: 400 })
  }

  const note = await prisma.ftSubmitterNote.create({
    data: {
      slackId,
      staffId: user.id,
      text: text.trim(),
      certId: certId ? parseInt(certId) : null,
      ticketId: ticketId ? parseInt(ticketId) : null,
    },
    include: { staff: { select: { username: true, avatar: true, slackId: true, role: true } } },
  })

  await log({
    action: 'submitter_note_added',
    status: 200,
    user,
    context: text.trim().substring(0, 100),
    target: { type: 'submitter', id: 0 },
    meta: { ip, ua, slackId },
  })

  return NextResponse.json({
    note: {
      id: note.id,
      text: note.text,
      certId: note.certId,
      ticketId: note.ticketId,
      createdAt: note.createdAt,
      staff: note.staff.username,
      staffSlackId: note.staff.slackId,
      staffRole: note.staff.role,
      staffAvatar: note.staff.avatar,
    },
  })
})
