module("modules.logic.survival.view.reputation.SurvivalReputationSelectView", package.seeall)

local var_0_0 = class("SurvivalReputationSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrollbuild = gohelper.findChildScrollRect(arg_1_0.viewGO, "build/#scroll_build")
	arg_1_0._gobuildcontent = gohelper.findChild(arg_1_0.viewGO, "build/#scroll_build/Viewport/#go_build_content")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "Btn/score/#txt_score")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_confirm")
	arg_1_0._btnconfirmgrey = gohelper.findChild(arg_1_0.viewGO, "Btn/#btn_confirm_grey")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "item/#scroll_item")
	arg_1_0.txt_tips = gohelper.findChildTextMesh(arg_1_0.viewGO, "titlebg/txt_tips")
	arg_1_0.customItems = {}

	arg_1_0:createItemScroll()

	arg_1_0._sequence = FlowSequence.New()
end

function var_0_0.createItemScroll(arg_2_0)
	local var_2_0 = SurvivalSimpleListParam.New()

	var_2_0.cellClass = SurvivalReputationSelectBagItem
	var_2_0.lineCount = 1
	var_2_0.cellWidth = 200
	var_2_0.cellHeight = 200
	var_2_0.cellSpaceH = 0
	var_2_0.cellSpaceV = 0

	local var_2_1 = arg_2_0.viewContainer:getSetting().otherRes.survivalreputationselectbagitem

	arg_2_0.survivalSimpleListComp = SurvivalHelper.instance:createLuaSimpleListComp(arg_2_0._scrollitem.gameObject, var_2_0, var_2_1, arg_2_0.viewContainer)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addClickCb(arg_3_0._btnconfirm, arg_3_0.onClickBtnConfirm, arg_3_0)
	arg_3_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalReputationExpReply, arg_3_0.onReceiveSurvivalReputationExpReply, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.isReceiveMsg = nil
	arg_4_0.items = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Shelter):getReputationItem()
	arg_4_0.score = SurvivalReputationModel.instance:getSelectViewReputationAdd(arg_4_0.items)
	arg_4_0._txtscore.text = arg_4_0.score

	arg_4_0:refreshItemList()
	arg_4_0:refreshBuildList()
	arg_4_0:refreshBtnConfirm()
	arg_4_0:refreshTextTip()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideSurvivalReputationSelectViewOpen)
end

function var_0_0.onClose(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	if arg_6_0._sequence and arg_6_0._sequence.status == WorkStatus.Running then
		arg_6_0._sequence:stop()
	end
end

function var_0_0.refreshItemList(arg_7_0)
	arg_7_0.survivalSimpleListComp:setList(arg_7_0.items)
end

function var_0_0.refreshBtnConfirm(arg_8_0)
	gohelper.setActive(arg_8_0._btnconfirm.gameObject, arg_8_0.curSelect ~= nil)
	gohelper.setActive(arg_8_0._btnconfirmgrey, arg_8_0.curSelect == nil)
end

function var_0_0.onClickBtnConfirm(arg_9_0)
	if arg_9_0.isReceiveMsg then
		return
	end

	local var_9_0 = arg_9_0.customItems[arg_9_0.curSelect].reputationId

	SurvivalWeekRpc.instance:sendSurvivalReputationExpRequest(var_9_0)
end

function var_0_0.onReceiveSurvivalReputationExpReply(arg_10_0, arg_10_1)
	arg_10_0.isReceiveMsg = true

	local var_10_0 = arg_10_1.msg.building
	local var_10_1

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.customItems) do
		if iter_10_1.buildingCfgId == var_10_0.buildingId then
			var_10_1 = arg_10_0.customItems[iter_10_0]
		end
	end

	local var_10_2 = FlowSequence.New()

	var_10_2:addWork(FunctionWork.New(arg_10_0.playItemAnim, arg_10_0))
	var_10_2:addWork(AnimatorWork.New({
		animName = "uiclose",
		go = arg_10_0.viewGO
	}))
	var_10_2:addWork(var_10_1:playUpAnim(var_10_0))
	var_10_2:addWork(TimerWork.New(0.5))
	arg_10_0._sequence:addWork(var_10_2)
	arg_10_0._sequence:registerDoneListener(arg_10_0.onAnimalPlayCallBack, arg_10_0)
	arg_10_0._sequence:start()
end

function var_0_0.playItemAnim(arg_11_0)
	local var_11_0 = arg_11_0.survivalSimpleListComp:getItems()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		iter_11_1:playSearch()
	end
end

function var_0_0.onAnimalPlayCallBack(arg_12_0)
	arg_12_0:closeThis()
end

function var_0_0.refreshBuildList(arg_13_0)
	local var_13_0 = arg_13_0.viewContainer:getSetting().otherRes.survivalreputationbuilditem
	local var_13_1 = SurvivalShelterModel.instance:getWeekInfo():getReputationBuilds()
	local var_13_2 = #arg_13_0.customItems
	local var_13_3 = #var_13_1

	for iter_13_0 = 1, var_13_3 do
		local var_13_4 = var_13_1[iter_13_0]

		if var_13_2 < iter_13_0 then
			local var_13_5 = arg_13_0:getResInst(var_13_0, arg_13_0._gobuildcontent)

			arg_13_0.customItems[iter_13_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_5, SurvivalReputationBuildItem)
		end

		arg_13_0.customItems[iter_13_0]:setData({
			score = arg_13_0.score,
			mo = var_13_4,
			index = iter_13_0,
			onClickCallBack = arg_13_0.onClickCallBack,
			onClickContext = arg_13_0,
			onAnimalPlayCallBack = arg_13_0.onAnimalPlayCallBack
		})
	end

	for iter_13_1 = var_13_3 + 1, var_13_2 do
		arg_13_0.customItems[iter_13_1]:setData(nil)
	end
end

function var_0_0.onClickCallBack(arg_14_0, arg_14_1)
	if not arg_14_1.isMaxLevel then
		arg_14_0:setSelect(arg_14_1.index)
	end
end

function var_0_0.setSelect(arg_15_0, arg_15_1)
	if arg_15_0.isReceiveMsg then
		return
	end

	if (not arg_15_1 or not arg_15_0.curSelect or arg_15_0.curSelect ~= arg_15_1) and (not not arg_15_1 or not not arg_15_0.curSelect) then
		if arg_15_0.curSelect then
			arg_15_0.customItems[arg_15_0.curSelect]:setSelect(false)
		end

		arg_15_0.curSelect = arg_15_1

		if arg_15_0.curSelect then
			arg_15_0.customItems[arg_15_0.curSelect]:setSelect(true)
		end
	end

	arg_15_0:refreshBtnConfirm()
	arg_15_0:refreshTextTip()
end

function var_0_0.refreshTextTip(arg_16_0)
	if arg_16_0.curSelect then
		local var_16_0 = arg_16_0.customItems[arg_16_0.curSelect]

		arg_16_0.txt_tips.text = var_16_0.buildCfg.desc
	else
		arg_16_0.txt_tips.text = ""
	end
end

return var_0_0
