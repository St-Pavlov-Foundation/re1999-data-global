module("modules.logic.playercard.view.PlayerCardCritterPlaceItem", package.seeall)

local var_0_0 = class("PlayerCardCritterPlaceItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "#go_icon")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_click")
	arg_1_0._uiclick = gohelper.getClickWithDefaultAudio(arg_1_0._goclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._uiclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._uiclick:AddClickDownListener(arg_2_0._btnclickOnClickDown, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._uiclick:RemoveClickListener()
	arg_3_0._uiclick:RemoveClickDownListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:getCritterId()

	arg_4_0.filterMO = CritterFilterModel.instance:generateFilterMO(ViewName.PlayerCardCritterPlaceView)

	PlayerCardModel.instance:setSelectCritterUid(var_4_0)
	PlayerCardRpc.instance:sendSetPlayerCardCritterRequest(var_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:setCritter()
end

function var_0_0.setCritter(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:getCritterId()

	if not arg_7_0.critterIcon then
		arg_7_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_7_0._goicon)

		arg_7_0.critterIcon:setSelectUIVisible(true)
	end

	arg_7_0.critterIcon:setMOValue(var_7_0, var_7_1)
	arg_7_0.critterIcon:showSpeical()
	arg_7_0.critterIcon:setMaturityIconShow(true)
	arg_7_0:_refreshSelect()
end

function var_0_0._refreshSelect(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:getCritterId()

	arg_8_0._isSelect = tonumber(var_8_0) == PlayerCardModel.instance:getSelectCritterUid()

	arg_8_0.critterIcon:onSelect(arg_8_0._isSelect)
end

function var_0_0.getCritterId(arg_9_0)
	local var_9_0
	local var_9_1

	if arg_9_0._mo then
		var_9_0 = arg_9_0._mo:getId()
		var_9_1 = arg_9_0._mo:getDefineId()
	end

	return var_9_0, var_9_1
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0
