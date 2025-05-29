module("modules.logic.rouge.map.view.map.RougeMapLayerRightView", package.seeall)

local var_0_0 = class("RougeMapLayerRightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goLayerRight = gohelper.findChild(arg_1_0.viewGO, "#go_layer_right")
	arg_1_0.simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_layer_right/RightBG2/#simage_newrightbg")
	arg_1_0._gopic = gohelper.findChild(arg_1_0.viewGO, "#go_layer_right/#go_pic")
	arg_1_0.simagelayerbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_layer_right/#go_pic/#simage_picbg")
	arg_1_0.simagelayerpic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_layer_right/#go_pic/#simage_pic")
	arg_1_0._txtChapterName = gohelper.findChildText(arg_1_0.viewGO, "#go_layer_right/Title/#txt_ChapterName")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_layer_right/#txt_Desc")
	arg_1_0._btnNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_layer_right/Title/#btn_next")
	arg_1_0._btnLast = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_layer_right/Title/#btn_last")
	arg_1_0._btnMove = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_layer_right/#btn_MoveBtn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnNext:AddClickListener(arg_2_0._btnNextOnClick, arg_2_0)
	arg_2_0._btnLast:AddClickListener(arg_2_0._btnLastOnClick, arg_2_0)
	arg_2_0._btnMove:AddClickListener(arg_2_0._btnMoveOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnNext:RemoveClickListener()
	arg_3_0._btnLast:RemoveClickListener()
	arg_3_0._btnMove:RemoveClickListener()
end

function var_0_0._btnLastOnClick(arg_4_0)
	if arg_4_0.curSelectIndex <= 1 then
		return
	end

	arg_4_0.curSelectIndex = arg_4_0.curSelectIndex - 1

	arg_4_0:changeSelectLayer()
end

function var_0_0._btnNextOnClick(arg_5_0)
	if arg_5_0.curSelectIndex >= arg_5_0.nextLayerLen then
		return
	end

	arg_5_0.curSelectIndex = arg_5_0.curSelectIndex + 1

	arg_5_0:changeSelectLayer()
end

function var_0_0.changeSelectLayer(arg_6_0)
	local var_6_0 = arg_6_0.nextLayerList[arg_6_0.curSelectIndex]

	RougeMapModel.instance:updateSelectLayerId(var_6_0)
end

function var_0_0._btnMoveOnClick(arg_7_0)
	RougeRpc.instance:sendRougeLeaveMiddleLayerRequest(arg_7_0.layerCo.id)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.simagerightbg:LoadImage("singlebg/rouge/map/rouge_map_detailbg2.png")
	arg_8_0.simagelayerbg:LoadImage("singlebg/rouge/map/rouge_map_detailbg3.png")

	arg_8_0.goNextBtn = arg_8_0._btnNext.gameObject
	arg_8_0.goLastBtn = arg_8_0._btnLast.gameObject
	arg_8_0.layerAnimator = arg_8_0.goLayerRight:GetComponent(gohelper.Type_Animator)

	arg_8_0:hide()
	arg_8_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLayerChange, arg_8_0.onSelectLayerChange, arg_8_0)
	arg_8_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_8_0.onChangeMapInfo, arg_8_0)
	arg_8_0:addEventCb(RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, arg_8_0.onPathSelectMapFocusDone, arg_8_0)
end

function var_0_0.onChangeMapInfo(arg_9_0)
	if not RougeMapModel.instance:isPathSelect() then
		arg_9_0:hide()

		return
	end

	arg_9_0:initData()
end

function var_0_0.onSelectLayerChange(arg_10_0, arg_10_1)
	arg_10_0.layerCo = lua_rouge_layer.configDict[arg_10_1]

	arg_10_0:updateSelectIndex()
	arg_10_0.layerAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(arg_10_0.refresh, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0.refresh, arg_10_0, RougeMapEnum.WaitMapRightRefreshTime)
end

function var_0_0.onOpen(arg_11_0)
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	arg_11_0:initData()
end

function var_0_0.initData(arg_12_0)
	arg_12_0.nextLayerList = RougeMapModel.instance:getNextLayerList()
	arg_12_0.nextLayerLen = #arg_12_0.nextLayerList

	local var_12_0 = RougeMapModel.instance:getSelectLayerId()

	arg_12_0.layerCo = lua_rouge_layer.configDict[var_12_0]

	arg_12_0:updateSelectIndex()
end

function var_0_0.updateSelectIndex(arg_13_0)
	arg_13_0.curSelectIndex = 1

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.nextLayerList) do
		if arg_13_0.layerCo.id == iter_13_1 then
			arg_13_0.curSelectIndex = iter_13_0
		end
	end
end

function var_0_0.onPathSelectMapFocusDone(arg_14_0)
	arg_14_0:refresh()
end

function var_0_0.refresh(arg_15_0)
	arg_15_0:show()
	arg_15_0:refreshLayerInfo()
	arg_15_0:refreshArrow()
	arg_15_0:refreshImage()
end

function var_0_0.refreshLayerInfo(arg_16_0)
	arg_16_0._txtChapterName.text = arg_16_0.layerCo.name
	arg_16_0._txtDesc.text = arg_16_0.layerCo.desc
end

function var_0_0.refreshArrow(arg_17_0)
	gohelper.setActive(arg_17_0.goNextBtn, arg_17_0.curSelectIndex < arg_17_0.nextLayerLen)
	gohelper.setActive(arg_17_0.goLastBtn, arg_17_0.curSelectIndex > 1)
end

function var_0_0.refreshImage(arg_18_0)
	local var_18_0 = arg_18_0.layerCo.iconRes

	if string.nilorempty(var_18_0) then
		return
	end

	local var_18_1 = string.format("singlebg/rouge/mapdetail/%s.png", var_18_0)

	arg_18_0.simagelayerpic:LoadImage(var_18_1)
end

function var_0_0.show(arg_19_0)
	gohelper.setActive(arg_19_0.goLayerRight, true)
end

function var_0_0.hide(arg_20_0)
	gohelper.setActive(arg_20_0.goLayerRight, false)
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0.simagerightbg:UnLoadImage()
	arg_21_0.simagelayerbg:UnLoadImage()
	arg_21_0.simagelayerpic:UnLoadImage()
	TaskDispatcher.cancelTask(arg_21_0.refresh, arg_21_0)
end

return var_0_0
