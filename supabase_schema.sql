-- =============================================
-- Todolist 앱 DB 스키마
-- Supabase SQL Editor에서 실행하세요
-- =============================================

-- groups 테이블
CREATE TABLE public.groups (
  id          UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  name        TEXT        NOT NULL UNIQUE,
  user_id     UUID        REFERENCES auth.users(id),  -- 로그인 추가 시 사용
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- todos 테이블
CREATE TABLE public.todos (
  id           UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  text         TEXT        NOT NULL,
  description  TEXT        DEFAULT '',
  group_name   TEXT        DEFAULT '',
  done         BOOLEAN     DEFAULT FALSE,
  completed_at TEXT,
  user_id      UUID        REFERENCES auth.users(id),  -- 로그인 추가 시 사용
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- RLS 활성화
ALTER TABLE public.groups ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.todos  ENABLE ROW LEVEL SECURITY;

-- =============================================
-- 현재 정책: 로그인 없이 전체 허용 (임시)
-- 로그인 기능 추가 후 아래 "로그인 후 교체할 정책"으로 교체하세요
-- =============================================
CREATE POLICY "temporary_allow_all_groups"
  ON public.groups FOR ALL
  USING (true) WITH CHECK (true);

CREATE POLICY "temporary_allow_all_todos"
  ON public.todos FOR ALL
  USING (true) WITH CHECK (true);


-- =============================================
-- 로그인 후 교체할 정책 (지금은 실행하지 마세요)
-- =============================================
-- DROP POLICY "temporary_allow_all_groups" ON public.groups;
-- DROP POLICY "temporary_allow_all_todos"  ON public.todos;
--
-- CREATE POLICY "user_groups" ON public.groups FOR ALL
--   USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
--
-- CREATE POLICY "user_todos" ON public.todos FOR ALL
--   USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
