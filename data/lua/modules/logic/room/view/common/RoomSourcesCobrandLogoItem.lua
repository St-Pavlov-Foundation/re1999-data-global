module("modules.logic.room.view.common.RoomSourcesCobrandLogoItem", package.seeall)

local var_0_0 = class("RoomSourcesCobrandLogoItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagelogoicon = gohelper.findChildImage(arg_1_0.viewGO, "logo/#image_logoicon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	return
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0.setSourcesTypeStr(arg_10_0, arg_10_1)
	arg_10_0._sourcesTypeCfg = arg_10_0:_findSourcesTypeCfg(arg_10_1)
	arg_10_0._isShow = false

	if arg_10_0._sourcesTypeCfg then
		arg_10_0._isShow = true

		UISpriteSetMgr.instance:setRoomSprite(arg_10_0._imagelogoicon, arg_10_0._sourcesTypeCfg.bgIcon)
	end

	gohelper.setActive(arg_10_0.viewGO, arg_10_0._isShow)
end

function var_0_0.getIsShow(arg_11_0)
	return arg_11_0._isShow
end

function var_0_0._findSourcesTypeCfg(arg_12_0, arg_12_1)
	if not arg_12_1 or string.nilorempty(arg_12_1) then
		return nil
	end

	local var_12_0 = string.splitToNumber(arg_12_1, "#")

	if var_12_0 == nil or #var_12_0 < 1 then
		return nil
	end

	local var_12_1
	local var_12_2 = RoomEnum.SourcesShowType.Cobrand

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_3 = RoomConfig.instance:getSourcesTypeConfig(iter_12_1)

		if var_12_3 and var_12_3.showType == var_12_2 then
			var_12_1 = var_12_3

			break
		end
	end

	return var_12_1
end

return var_0_0
