import { NextResponse } from 'next/server'
import { prisma } from '@/lib/db'
import { PERMS } from '@/lib/perms'
import { log } from '@/lib/log'
import { withParams } from '@/lib/api'

export const DELETE = withParams<{ slackId: string; noteId: string }>(PERMS.submitter_delete)(
  async ({ user, params, ip, ua }) => {
    const noteId = parseInt(params.noteId)
    if (isNaN(noteId)) return NextResponse.json({ error: 'bad note id' }, { status: 400 })

    const note = await prisma.ftSubmitterNote.findUnique({ where: { id: noteId } })
    if (!note) return NextResponse.json({ error: 'note not found' }, { status: 404 })

    await prisma.ftSubmitterNote.delete({ where: { id: noteId } })

    await log({
      action: 'submitter_note_deleted',
      status: 200,
      user,
      context: note.text.substring(0, 100),
      target: { type: 'submitter', id: 0 },
      meta: { ip, ua, slackId: params.slackId },
    })

    return NextResponse.json({ ok: true })
  }
)
