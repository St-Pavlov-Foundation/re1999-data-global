-- chunkname: @modules/logic/versionactivity220/define/Activity220Event.lua

module("modules.logic.versionactivity220.define.Activity220Event", package.seeall)

local Activity220Event = _M

Activity220Event.GetAct220InfoReply = 10000
Activity220Event.SaveEpisodeProgressReply = 10001
Activity220Event.FinishEpisodeReply = 10002
Activity220Event.ChooseEpisodeBranchReply = 10003
Activity220Event.EpisodePush = 10004
Activity220Event.EpisodeFinished = 10005

return Activity220Event
