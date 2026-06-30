-- =============================================
-- RLS 정책 업데이트 (로그인 기능 추가 후 실행)
-- Supabase SQL Editor에서 실행하세요
-- =============================================

-- 임시 전체 허용 정책 삭제
DROP POLICY IF EXISTS "temporary_allow_all_groups" ON public.groups;
DROP POLICY IF EXISTS "temporary_allow_all_todos"  ON public.todos;

-- 회원별 데이터 접근 정책 추가
CREATE POLICY "user_groups" ON public.groups FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

CREATE POLICY "user_todos" ON public.todos FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
