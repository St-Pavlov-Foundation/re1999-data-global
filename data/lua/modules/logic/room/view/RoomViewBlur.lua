module("modules.logic.room.view.RoomViewBlur", package.seeall)

local var_0_0 = class("RoomViewBlur", BaseView)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
	arg_4_0._blurGO = nil
	arg_4_0._material = nil
end

function var_0_0._refreshUI(arg_5_0)
	if not arg_5_0._blurGO then
		arg_5_0._blurGO = arg_5_0.viewContainer:getResInst("ppassets/uixiaowumask.prefab", arg_5_0.viewGO, "blur")
		arg_5_0._material = arg_5_0._blurGO:GetComponent(typeof(UnityEngine.UI.Image)).material

		arg_5_0:_updateBlur(0)
	end
end

function var_0_0._updateBlur(arg_6_0, arg_6_1)
	if not arg_6_0._material then
		return
	end

	arg_6_1 = arg_6_1 or 0

	arg_6_0._material:SetFloat("_ChangeTax", arg_6_1)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateBlur, arg_7_0._updateBlur, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._material = nil
end

return var_0_0
