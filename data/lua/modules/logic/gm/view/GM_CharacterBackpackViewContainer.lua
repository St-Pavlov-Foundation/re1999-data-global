module("modules.logic.gm.view.GM_CharacterBackpackViewContainer", package.seeall)

local var_0_0 = class("GM_CharacterBackpackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		GM_CharacterBackpackView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

function var_0_0.addEvents(arg_3_0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_ShowAllTabIdUpdate, arg_3_0._gm_showAllTabIdUpdate, arg_3_0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_EnableCheckFaceOnSelect, arg_3_0._gm_enableCheckFaceOnSelect, arg_3_0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_EnableCheckMouthOnSelect, arg_3_0._gm_enableCheckMouthOnSelect, arg_3_0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_EnableCheckContentOnSelect, arg_3_0._gm_enableCheckContentOnSelect, arg_3_0)
	GMController.instance:registerCallback(GMEvent.CharacterBackpackView_EnableCheckMotionOnSelect, arg_3_0._gm_enableCheckMotionOnSelect, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_ShowAllTabIdUpdate, arg_4_0._gm_showAllTabIdUpdate, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_EnableCheckFaceOnSelect, arg_4_0._gm_enableCheckFaceOnSelect, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_EnableCheckMouthOnSelect, arg_4_0._gm_enableCheckMouthOnSelect, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_EnableCheckContentOnSelect, arg_4_0._gm_enableCheckContentOnSelect, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.CharacterBackpackView_EnableCheckMotionOnSelect, arg_4_0._gm_enableCheckMotionOnSelect, arg_4_0)
end

return var_0_0
