import { NextResponse } from 'next/server'
import { PERMS } from '@/lib/perms'
import { getCerts } from '@/lib/certs'
import { api } from '@/lib/api'

export const GET = api(PERMS.certs_view)(async ({ req }) => {
  try {
    const { searchParams } = new URL(req.url)
    const type = searchParams.get('type')
    const ftType = searchParams.get('ftType')
    const status = searchParams.get('status')
    const sortBy = searchParams.get('sortBy') || 'newest'
    const lbMode = searchParams.get('lbMode') || 'weekly'
    const from = searchParams.get('from')
    const to = searchParams.get('to')
    const search = searchParams.get('search')

    const data = await getCerts({ type, ftType, status, sortBy, lbMode, from, to, search })
    return NextResponse.json(data)
  } catch {
    return NextResponse.json({ error: 'shit hit the fan loading certifications' }, { status: 500 })
  }
})
