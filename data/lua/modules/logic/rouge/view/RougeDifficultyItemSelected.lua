module("modules.logic.rouge.view.RougeDifficultyItemSelected", package.seeall)

local var_0_0 = class("RougeDifficultyItemSelected", RougeDifficultyItem_Base)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goFrame1 = gohelper.findChild(arg_1_0.viewGO, "frame/#go_Frame1")
	arg_1_0._goFrame2 = gohelper.findChild(arg_1_0.viewGO, "frame/#go_Frame2")
	arg_1_0._goFrame3 = gohelper.findChild(arg_1_0.viewGO, "frame/#go_Frame3")
	arg_1_0._goBg1 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg1")
	arg_1_0._goBg2 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg2")
	arg_1_0._goBg3 = gohelper.findChild(arg_1_0.viewGO, "bg/#go_Bg3")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num1")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num2")
	arg_1_0._txtnum3 = gohelper.findChildText(arg_1_0.viewGO, "num/#txt_num3")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_en")
	arg_1_0._txtenemy = gohelper.findChildText(arg_1_0.viewGO, "enemy/#txt_enemy")
	arg_1_0._enemyGo1 = gohelper.findChild(arg_1_0.viewGO, "enemy/#go_1")
	arg_1_0._enemyGo2 = gohelper.findChild(arg_1_0.viewGO, "enemy/#go_2")
	arg_1_0._enemyGo3 = gohelper.findChild(arg_1_0.viewGO, "enemy/#go_3")
	arg_1_0._scoreGo1 = gohelper.findChild(arg_1_0.viewGO, "score/#go_1")
	arg_1_0._scoreGo2 = gohelper.findChild(arg_1_0.viewGO, "score/#go_2")
	arg_1_0._scoreGo3 = gohelper.findChild(arg_1_0.viewGO, "score/#go_3")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "score/#txt_score")
	arg_1_0._btnTipsIcon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#btn_TipsIcon")
	arg_1_0._btnBalance = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_balance")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._txtScrollDesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#txt_ScrollDesc")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTipsIcon:AddClickListener(arg_2_0._btnTipsIconOnClick, arg_2_0)
	arg_2_0._btnBalance:AddClickListener(arg_2_0._btnBalanceOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTipsIcon:RemoveClickListener()
	arg_3_0._btnBalance:RemoveClickListener()
end

function var_0_0._btnTipsIconOnClick(arg_4_0)
	local var_4_0 = arg_4_0._mo.difficultyCO.difficulty

	arg_4_0:dispatchEvent(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, var_4_0)
end

function var_0_0._btnBalanceOnClick(arg_5_0)
	local var_5_0 = arg_5_0._mo.difficultyCO.difficulty

	arg_5_0:dispatchEvent(RougeEvent.RougeDifficultyView_btnBalanceOnClick, var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	RougeDifficultyItem_Base._editableInitView(arg_6_0)

	arg_6_0._btnBalanceGo = arg_6_0._btnBalance.gameObject
	arg_6_0._btnTipsIconGo = arg_6_0._btnTipsIcon.gameObject
	arg_6_0._goFrameList = arg_6_0:getUserDataTb_()

	arg_6_0:_fillUserDataTb("_goFrame", arg_6_0._goFrameList)

	arg_6_0._goEnemyTxtBgList = arg_6_0:getUserDataTb_()

	arg_6_0:_fillUserDataTb("_enemyGo", arg_6_0._goEnemyTxtBgList)

	arg_6_0._goScoreTxtBgList = arg_6_0:getUserDataTb_()

	arg_6_0:_fillUserDataTb("_scoreGo", arg_6_0._goScoreTxtBgList)

	arg_6_0._scrolldescLimitScrollRectCmp = arg_6_0._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	arg_6_0:_onSetScrollParentGameObject(arg_6_0._scrolldescLimitScrollRectCmp)
	arg_6_0:_setActiveBalance(false)
	arg_6_0:_setActiveOverview(false)
end

function var_0_0.onDestroyView(arg_7_0)
	RougeDifficultyItem_Base.onDestroyView(arg_7_0)
end

function var_0_0.setData(arg_8_0, arg_8_1)
	RougeDifficultyItem_Base.setData(arg_8_0, arg_8_1)

	local var_8_0 = arg_8_0:staticData().geniusBranchStartViewInfo
	local var_8_1 = arg_8_1.difficultyCO
	local var_8_2 = var_8_1.difficulty
	local var_8_3 = var_8_1.balanceLevel
	local var_8_4 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(var_8_2)
	local var_8_5 = RougeOutsideModel.instance:config():getDifficultyCOStartViewDeltaValue(var_8_2, RougeEnum.StartViewEnum.point) + (var_8_0[RougeEnum.StartViewEnum.point] or 0)

	arg_8_0._txtenemy.text = var_8_2
	arg_8_0._txtscore.text = tostring(var_8_1.scoreReward + var_8_5) .. "%"
	arg_8_0._txtScrollDesc.text = var_8_1.desc

	arg_8_0:_activeStyle(arg_8_0._goFrameList, var_8_4)
	arg_8_0:_activeStyle(arg_8_0._goEnemyTxtBgList, var_8_4)
	arg_8_0:_activeStyle(arg_8_0._goScoreTxtBgList, var_8_4)
	arg_8_0:_setActiveBalance(not string.nilorempty(var_8_3))

	local var_8_6 = arg_8_0:baseViewContainer()

	if var_8_6 then
		arg_8_0:_setActiveOverview(#var_8_6:getSumDescIndexList(var_8_2) > 0)
	end
end

function var_0_0._activeStyle(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		gohelper.setActive(iter_9_1, false)
	end

	gohelper.setActive(arg_9_1[arg_9_2], true)
end

function var_0_0._setActiveBalance(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._btnBalanceGo, arg_10_1)
end

function var_0_0._setActiveOverview(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._btnTipsIconGo, arg_11_1)
end

return var_0_0
