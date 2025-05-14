module("modules.logic.achievement.controller.AchievementEvent", package.seeall)

local var_0_0 = _M

var_0_0.UpdateAchievements = 1001
var_0_0.SelectViewUpdated = 2001
var_0_0.LevelViewUpdated = 3001
var_0_0.AchievementMainViewUpdate = 4001
var_0_0.OnSwitchCategory = 4002
var_0_0.OnFocusAchievementFinished = 4003
var_0_0.OnClickGroupFoldBtn = 4004
var_0_0.OnPlayGroupFadeAnim = 4005
var_0_0.OnSwitchViewType = 4006
var_0_0.OnGroupUpGrade = 6001
var_0_0.AchievementSaveSucc = 8001
var_0_0.UpdateAchievementState = 9001
var_0_0.LoginShowToast = GameUtil.getEventId()

return var_0_0
