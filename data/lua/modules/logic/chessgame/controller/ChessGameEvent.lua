module("modules.logic.chessgame.controller.ChessGameEvent", package.seeall)

slot0 = _M
slot1 = GameUtil.getUniqueTb()
slot0.DeleteInteractAvatar = slot1()
slot0.GameMapDataUpdate = slot1()
slot0.SetNeedChooseDirectionVisible = slot1()
slot0.SetAlarmAreaVisible = slot1()
slot0.CurrentRoundUpdate = slot1()
slot0.GameLoadingMapStateUpdate = slot1()
slot0.GameReset = slot1()
slot0.RollBack = slot1()
slot0.AllObjectCreated = slot1()
slot0.AddInteractObj = slot1()
slot0.OnVictory = slot1()
slot0.OnFail = slot1()
slot0.GamePointReturn = slot1()
slot0.ChangeMap = slot1()
slot0.RefreshScene = slot1()
slot0.GameResultQuit = slot1()
slot0.PlayStoryFinish = slot1()
slot0.PlayDialogue = slot1()
slot0.DialogEnd = slot1()
slot0.ClickOnTalking = slot1()
slot0.CurrentConditionUpdate = slot1()
slot0.GuideStart = slot1()
slot0.GuideOnEnterEpisode = slot1()
slot0.GameToastUpdate = slot1()
slot0.EnterGameFinish = slot1()
slot0.LoadingMapState = {
	Start = 998,
	Finish = 999
}

return slot0
