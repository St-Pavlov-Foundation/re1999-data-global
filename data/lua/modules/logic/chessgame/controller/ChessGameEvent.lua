module("modules.logic.chessgame.controller.ChessGameEvent", package.seeall)

local var_0_0 = _M
local var_0_1 = GameUtil.getUniqueTb()

var_0_0.DeleteInteractAvatar = var_0_1()
var_0_0.GameMapDataUpdate = var_0_1()
var_0_0.SetNeedChooseDirectionVisible = var_0_1()
var_0_0.SetAlarmAreaVisible = var_0_1()
var_0_0.CurrentRoundUpdate = var_0_1()
var_0_0.GameLoadingMapStateUpdate = var_0_1()
var_0_0.GameReset = var_0_1()
var_0_0.RollBack = var_0_1()
var_0_0.AllObjectCreated = var_0_1()
var_0_0.AddInteractObj = var_0_1()
var_0_0.OnVictory = var_0_1()
var_0_0.OnFail = var_0_1()
var_0_0.GamePointReturn = var_0_1()
var_0_0.ChangeMap = var_0_1()
var_0_0.RefreshScene = var_0_1()
var_0_0.GameResultQuit = var_0_1()
var_0_0.PlayStoryFinish = var_0_1()
var_0_0.PlayDialogue = var_0_1()
var_0_0.DialogEnd = var_0_1()
var_0_0.ClickOnTalking = var_0_1()
var_0_0.CurrentConditionUpdate = var_0_1()
var_0_0.GuideStart = var_0_1()
var_0_0.GuideOnEnterEpisode = var_0_1()
var_0_0.GameToastUpdate = var_0_1()
var_0_0.EnterGameFinish = var_0_1()
var_0_0.LoadingMapState = {
	Start = 998,
	Finish = 999
}

return var_0_0
