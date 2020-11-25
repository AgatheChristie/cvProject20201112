%% coding: latin-1

-ifndef(TIME_ENGINE_HRL).
-define(TIME_ENGINE_HRL, true).

%% 定时事件
-define(TIMING_MS_EVENT, timing_ms_event).
-define(TIMING_SEC_EVENT, timing_sec_event).

%% 场景循环进程字典
-define(PROCESS_LOOP_SEC, process_loop_sec).                                 %% 循环秒
-define(PROCESS_LOOP_MS, process_loop_ms).                                   %% 循环毫秒

%% 定时循环
-define(LOOP_EVENT_MS_TIME, 200).                                            %% 200毫秒
-define(LOOP_EVENT_SEC_TIME, 1000).                                          %% 1s

%% 循环时间间隔
-define(LOOP_EVENT_MS_DIFF, 200).
-define(LOOP_EVENT_SEC_DIFF, 1).

-endif.


