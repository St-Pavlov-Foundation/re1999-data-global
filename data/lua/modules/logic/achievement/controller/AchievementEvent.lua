module("modules.logic.achievement.controller.AchievementEvent", package.seeall)

slot0 = _M
slot0.UpdateAchievements = 1001
slot0.SelectViewUpdated = 2001
slot0.LevelViewUpdated = 3001
slot0.AchievementMainViewUpdate = 4001
slot0.OnSwitchCategory = 4002
slot0.OnFocusAchievementFinished = 4003
slot0.OnClickGroupFoldBtn = 4004
slot0.OnPlayGroupFadeAnim = 4005
slot0.OnSwitchViewType = 4006
slot0.OnGroupUpGrade = 6001
slot0.AchievementSaveSucc = 8001
slot0.UpdateAchievementState = 9001
slot0.LoginShowToast = GameUtil.getEventId()

return slot0
