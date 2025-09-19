module("modules.logic.mainuiswitch.view.MainUISwitchInfoHeroView", package.seeall)

local var_0_0 = class("MainUISwitchInfoHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospinescaleroot = gohelper.findChild(arg_1_0.viewGO, "root/#go_spine_scale")
	arg_1_0._gospineroot = gohelper.findChild(arg_1_0.viewGO, "root/#go_spine_scale/lightspine")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "root/#go_spine_scale/lightspine/#go_lightspine")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
end

function var_0_0._onSwitchUIVisible(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 and MainUISwitchEnum.MainUIScale or 1

	transformhelper.setLocalScale(arg_4_0._gospinescaleroot.transform, var_4_0, var_4_0, 1)
end

function var_0_0._editableInitView(arg_5_0)
	transformhelper.setLocalScale(arg_5_0._gospinescaleroot.transform, MainUISwitchEnum.MainUIScale, MainUISwitchEnum.MainUIScale, 1)
	transformhelper.setLocalScale(arg_5_0._gospineroot.transform, 1, 1, 1)
	recthelper.setAnchor(arg_5_0._gospineroot.transform, -200, -1174)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._heroId, arg_6_0._skinId = CharacterSwitchListModel.instance:getMainHero()
	arg_6_0._heroSkinConfig = SkinConfig.instance:getSkinCo(arg_6_0._skinId)

	arg_6_0:_updateHero()

	local var_6_0 = SkinConfig.instance:getSkinOffset(arg_6_0._heroSkinConfig.characterViewOffset)
	local var_6_1 = tonumber(var_6_0[3])

	recthelper.setAnchor(arg_6_0._gospine.transform, tonumber(var_6_0[1]), tonumber(var_6_0[2]))
	transformhelper.setLocalScale(arg_6_0._gospine.transform, var_6_1, var_6_1, var_6_1)

	local var_6_2 = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Drawing/spine")

	if var_6_2 then
		gohelper.setActive(var_6_2, false)
	end
end

function var_0_0._updateHero(arg_7_0)
	arg_7_0._uiSpine = GuiModelAgent.Create(arg_7_0._gospine, true)

	arg_7_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_7_0.viewName)
	arg_7_0:_loadSpine()
end

function var_0_0._loadSpine(arg_8_0)
	arg_8_0._uiSpine:setResPath(arg_8_0._heroSkinConfig, arg_8_0._onSpineLoaded, arg_8_0)
end

function var_0_0._onSpineLoaded(arg_9_0)
	arg_9_0._spineLoaded = true
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._uiSpine then
		arg_10_0._uiSpine:onDestroy()

		arg_10_0._uiSpine = nil
	end
end

return var_0_0
