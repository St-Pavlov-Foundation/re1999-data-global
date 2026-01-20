-- chunkname: @modules/logic/story/controller/StoryEvent.lua

module("modules.logic.story.controller.StoryEvent", package.seeall)

local StoryEvent = _M

StoryEvent.Start = 1
StoryEvent.StartFirstStep = 2
StoryEvent.Finish = 3
StoryEvent.EnterNextStep = 4
StoryEvent.AllStepFinished = 5
StoryEvent.FinishFromServer = 6
StoryEvent.OnBgmStop = 7
StoryEvent.Log = 1001
StoryEvent.Hide = 1002
StoryEvent.Auto = 1003
StoryEvent.Skip = 1004
StoryEvent.PvPause = 1005
StoryEvent.PvPlay = 1006
StoryEvent.SkipClick = 1007
StoryEvent.PlayDarkFadeUp = 2001
StoryEvent.PlayDarkFade = 2002
StoryEvent.PlayWhiteFade = 2003
StoryEvent.SetFullText = 2004
StoryEvent.PlayFullText = 2005
StoryEvent.PlayFullTextOut = 2006
StoryEvent.PlayFullBlurIn = 2007
StoryEvent.PlayFullTextLineShow = 2008
StoryEvent.FullTextLineShowFinished = 2009
StoryEvent.StoryFrontViewDestroy = 2010
StoryEvent.PlayIrregularShakeText = 2011
StoryEvent.PlayFullBlurOut = 2012
StoryEvent.RefreshStep = 3001
StoryEvent.RefreshBackground = 3002
StoryEvent.RefreshView = 3003
StoryEvent.RefreshConversation = 3004
StoryEvent.ShowBackground = 3005
StoryEvent.ReOpenStoryView = 3006
StoryEvent.ShowLeadRole = 3007
StoryEvent.ConversationShake = 3008
StoryEvent.LeadRoleViewShow = 3009
StoryEvent.RefreshHero = 3010
StoryEvent.RefreshNavigate = 3011
StoryEvent.LogSelected = 3012
StoryEvent.LogAudioFinished = 3013
StoryEvent.FrontItemFadeOut = 3014
StoryEvent.OnSelectOptionView = 3015
StoryEvent.FinishSelectOptionView = 3016
StoryEvent.HideTopBtns = 3017
StoryEvent.HideDialog = 3018
StoryEvent.DialogConFinished = 3019
StoryEvent.VideoStart = 3040
StoryEvent.VideoChange = 3041
StoryEvent.AutoChange = 3042
StoryEvent.OnSkipClick = 3031
StoryEvent.OnReplaceHero = 4001
StoryEvent.OnFollowPicture = 5001
StoryEvent.OnHeroShowed = 5002

return StoryEvent
