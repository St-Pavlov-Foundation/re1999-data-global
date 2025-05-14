module("modules.logic.room.view.critter.summon.RoomCritterSummonPoolItem", package.seeall)

local var_0_0 = class("RoomCritterSummonPoolItem", ListScrollCellExtend)

function var_0_0.onUpdateMO(arg_1_0, arg_1_1)
	if not arg_1_0._iconItem then
		local var_1_0 = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlCritterIcon, arg_1_0.viewGO)

		if var_1_0 then
			arg_1_0._iconItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, RoomCritterSummonPoolIcon)
		end
	end

	arg_1_0._iconItem:onUpdateMO(arg_1_1)
	arg_1_0._iconItem:setCustomClick(arg_1_0.onClicKCallback, arg_1_0, arg_1_1)
end

function var_0_0.onClicKCallback(arg_2_0, arg_2_1)
	CritterController.instance:openRoomCritterDetailView(true, arg_2_1:getCritterMo(), true)
end

return var_0_0
