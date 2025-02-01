module("modules.logic.rouge.view.RougeDifficultyItemSelected", package.seeall)

slot0 = class("RougeDifficultyItemSelected", RougeDifficultyItem_Base)

function slot0.onInitView(slot0)
	slot0._goFrame1 = gohelper.findChild(slot0.viewGO, "frame/#go_Frame1")
	slot0._goFrame2 = gohelper.findChild(slot0.viewGO, "frame/#go_Frame2")
	slot0._goFrame3 = gohelper.findChild(slot0.viewGO, "frame/#go_Frame3")
	slot0._goBg1 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg1")
	slot0._goBg2 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg2")
	slot0._goBg3 = gohelper.findChild(slot0.viewGO, "bg/#go_Bg3")
	slot0._txtnum1 = gohelper.findChildText(slot0.viewGO, "num/#txt_num1")
	slot0._txtnum2 = gohelper.findChildText(slot0.viewGO, "num/#txt_num2")
	slot0._txtnum3 = gohelper.findChildText(slot0.viewGO, "num/#txt_num3")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_en")
	slot0._txtenemy = gohelper.findChildText(slot0.viewGO, "enemy/#txt_enemy")
	slot0._enemyGo1 = gohelper.findChild(slot0.viewGO, "enemy/#go_1")
	slot0._enemyGo2 = gohelper.findChild(slot0.viewGO, "enemy/#go_2")
	slot0._enemyGo3 = gohelper.findChild(slot0.viewGO, "enemy/#go_3")
	slot0._scoreGo1 = gohelper.findChild(slot0.viewGO, "score/#go_1")
	slot0._scoreGo2 = gohelper.findChild(slot0.viewGO, "score/#go_2")
	slot0._scoreGo3 = gohelper.findChild(slot0.viewGO, "score/#go_3")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "score/#txt_score")
	slot0._btnTipsIcon = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#btn_TipsIcon")
	slot0._btnBalance = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_balance")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._txtScrollDesc = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#txt_ScrollDesc")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTipsIcon:AddClickListener(slot0._btnTipsIconOnClick, slot0)
	slot0._btnBalance:AddClickListener(slot0._btnBalanceOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTipsIcon:RemoveClickListener()
	slot0._btnBalance:RemoveClickListener()
end

function slot0._btnTipsIconOnClick(slot0)
	slot0:dispatchEvent(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, slot0._mo.difficultyCO.difficulty)
end

function slot0._btnBalanceOnClick(slot0)
	slot0:dispatchEvent(RougeEvent.RougeDifficultyView_btnBalanceOnClick, slot0._mo.difficultyCO.difficulty)
end

function slot0._editableInitView(slot0)
	RougeDifficultyItem_Base._editableInitView(slot0)

	slot0._btnBalanceGo = slot0._btnBalance.gameObject
	slot0._btnTipsIconGo = slot0._btnTipsIcon.gameObject
	slot0._goFrameList = slot0:getUserDataTb_()

	slot0:_fillUserDataTb("_goFrame", slot0._goFrameList)

	slot0._goEnemyTxtBgList = slot0:getUserDataTb_()

	slot0:_fillUserDataTb("_enemyGo", slot0._goEnemyTxtBgList)

	slot0._goScoreTxtBgList = slot0:getUserDataTb_()

	slot0:_fillUserDataTb("_scoreGo", slot0._goScoreTxtBgList)

	slot0._scrolldescLimitScrollRectCmp = slot0._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	slot0:_onSetScrollParentGameObject(slot0._scrolldescLimitScrollRectCmp)
	slot0:_setActiveBalance(false)
	slot0:_setActiveOverview(false)
end

function slot0.onDestroyView(slot0)
	RougeDifficultyItem_Base.onDestroyView(slot0)
end

function slot0.setData(slot0, slot1)
	RougeDifficultyItem_Base.setData(slot0, slot1)

	slot4 = slot1.difficultyCO
	slot5 = slot4.difficulty
	slot7 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(slot5)
	slot0._txtenemy.text = slot5
	slot0._txtscore.text = tostring(slot4.scoreReward + RougeOutsideModel.instance:config():getDifficultyCOStartViewDeltaValue(slot5, RougeEnum.StartViewEnum.point) + (slot0:staticData().geniusBranchStartViewInfo[RougeEnum.StartViewEnum.point] or 0)) .. "%"
	slot0._txtScrollDesc.text = slot4.desc

	slot0:_activeStyle(slot0._goFrameList, slot7)
	slot0:_activeStyle(slot0._goEnemyTxtBgList, slot7)
	slot0:_activeStyle(slot0._goScoreTxtBgList, slot7)
	slot0:_setActiveBalance(not string.nilorempty(slot4.balanceLevel))

	if slot0:baseViewContainer() then
		slot0:_setActiveOverview(#slot12:getSumDescIndexList(slot5) > 0)
	end
end

function slot0._activeStyle(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		gohelper.setActive(slot7, false)
	end

	gohelper.setActive(slot1[slot2], true)
end

function slot0._setActiveBalance(slot0, slot1)
	gohelper.setActive(slot0._btnBalanceGo, slot1)
end

function slot0._setActiveOverview(slot0, slot1)
	gohelper.setActive(slot0._btnTipsIconGo, slot1)
end

return slot0
