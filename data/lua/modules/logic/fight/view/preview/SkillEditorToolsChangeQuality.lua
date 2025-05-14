module("modules.logic.fight.view.preview.SkillEditorToolsChangeQuality", package.seeall)

local var_0_0 = class("SkillEditorToolsChangeQuality", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0._editableInitView(arg_3_0)
	return
end

function var_0_0.onRefreshViewParam(arg_4_0)
	return
end

function var_0_0._onBtnClick(arg_5_0)
	arg_5_0:getParentView():hideToolsBtnList()
	gohelper.setActive(arg_5_0._btn, true)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:getParentView():addToolBtn("画质", arg_6_0._onBtnClick, arg_6_0)

	arg_6_0._btn = arg_6_0:getParentView():addToolViewObj("画质")
	arg_6_0._item = gohelper.findChild(arg_6_0._btn, "variant")

	arg_6_0:_showData()
end

function var_0_0._showData(arg_7_0)
	local var_7_0 = {
		ModuleEnum.Performance.High,
		ModuleEnum.Performance.Middle,
		ModuleEnum.Performance.Low
	}

	arg_7_0:com_createObjList(arg_7_0._onItemShow, var_7_0, arg_7_0._btn, arg_7_0._item)
end

function var_0_0._onItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildText(arg_8_1, "Text")
	local var_8_1 = ""

	if arg_8_2 == ModuleEnum.Performance.High then
		var_8_1 = "高"
	elseif arg_8_2 == ModuleEnum.Performance.Middle then
		var_8_1 = "中"
	elseif arg_8_2 == ModuleEnum.Performance.Low then
		var_8_1 = "低"
	end

	var_8_0.text = var_8_1

	local var_8_2 = gohelper.getClick(arg_8_1)

	arg_8_0:addClickCb(var_8_2, arg_8_0._onItemClick, arg_8_0, arg_8_2)
end

function var_0_0._onItemClick(arg_9_0, arg_9_1)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_9_1)
	FightEffectPool.dispose()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
