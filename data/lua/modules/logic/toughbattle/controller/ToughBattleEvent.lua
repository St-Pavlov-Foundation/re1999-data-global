module("modules.logic.toughbattle.controller.ToughBattleEvent", package.seeall)

slot0 = _M
slot1 = GameUtil.getUniqueTb()
slot0.StageUpdate = slot1()
slot0.ToughBattleActChange = slot1()
slot0.InitFightIndex = slot1()
slot0.ToughBattleActBtnShow = slot1()
slot0.BeginPlayFightSucessAnim = slot1()
slot0.GuideCurStage = slot1()
slot0.GuideSetElementsActive = slot1()
slot0.GuideFocusElement = slot1()
slot0.GuideClickElement = slot1()
slot0.GuideOpenBossInfoView = slot1()

return slot0
