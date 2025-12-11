module("modules.logic.survival.view.handbook.SurvivalHandbookInfoView", package.seeall)

local var_0_0 = class("SurvivalHandbookInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btnClose")
	arg_1_0.btnLeftArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btnLeftArrow")
	arg_1_0.btnRightArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btnRightArrow")
	arg_1_0.infoViewNode = gohelper.findChild(arg_1_0.viewGO, "#infoViewNode")
	arg_1_0.textIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "#textIndex")
	arg_1_0.refreshFlow = FlowSequence.New()

	arg_1_0.refreshFlow:addWork(TimerWork.New(0.167))
	arg_1_0.refreshFlow:addWork(FunctionWork.New(arg_1_0.refreshInfo, arg_1_0))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.closeThis, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnLeftArrow, arg_2_0.onClickBtnLeftArrow, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRightArrow, arg_2_0.onClickBtnRightArrow, arg_2_0)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0.handBookType = arg_3_0.viewParam.handBookType
	arg_3_0.handBookDatas = arg_3_0.viewParam.handBookDatas
	arg_3_0.select = arg_3_0.viewParam.select

	local var_3_0 = arg_3_0.viewContainer._viewSetting.otherRes.infoView
	local var_3_1 = arg_3_0:getResInst(var_3_0, arg_3_0.infoViewNode)

	arg_3_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_1, SurvivalBagInfoPart)

	arg_3_0._infoPanel:setIsShowEmpty(true)
	arg_3_0:refreshInfo()
end

function var_0_0.onClose(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0.refreshFlow:clearWork()
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onClickBtnLeftArrow(arg_7_0)
	if arg_7_0.select > 1 then
		arg_7_0.select = arg_7_0.select - 1
	end

	arg_7_0._infoPanel:playAnim("switchleft")
	arg_7_0.refreshFlow:clearWork()
	arg_7_0.refreshFlow:start()
end

function var_0_0.onClickBtnRightArrow(arg_8_0)
	if arg_8_0.select < #arg_8_0.handBookDatas then
		arg_8_0.select = arg_8_0.select + 1
	end

	arg_8_0._infoPanel:playAnim("switchright")
	arg_8_0.refreshFlow:clearWork()
	arg_8_0.refreshFlow:start()
end

function var_0_0.refreshArrow(arg_9_0)
	gohelper.setActive(arg_9_0.btnLeftArrow, arg_9_0.select > 1)
	gohelper.setActive(arg_9_0.btnRightArrow, arg_9_0.select < #arg_9_0.handBookDatas)

	arg_9_0.textIndex.text = string.format("%s/%s", arg_9_0.select, #arg_9_0.handBookDatas)
end

function var_0_0.refreshInfo(arg_10_0)
	arg_10_0:refreshArrow()

	local var_10_0 = arg_10_0.handBookDatas[arg_10_0.select]

	arg_10_0._infoPanel:updateMo(var_10_0:getSurvivalBagItemMo(), {
		jumpChangeAnim = true
	})
end

return var_0_0
