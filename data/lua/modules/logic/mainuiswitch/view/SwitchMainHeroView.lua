module("modules.logic.mainuiswitch.view.SwitchMainHeroView", package.seeall)

local var_0_0 = class("SwitchMainHeroView", BaseView)
local var_0_1 = WeatherController.instance

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0.viewGO, "#go_lightspinecontrol")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_en")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0:_showHero()
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
	arg_3_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_4_0._onSwitchUIVisible, arg_4_0)
	arg_4_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_4_0._toSwitchTab, arg_4_0)
end

function var_0_0._toSwitchTab(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 1 then
		if arg_5_0.viewContainer:getClassify() == MainSwitchClassifyEnum.Classify.UI then
			if arg_5_2 == MainEnum.SwitchType.Scene then
				arg_5_0:onTabSwitchOpen()
			else
				arg_5_0:onTabSwitchClose()
			end
		end
	elseif arg_5_1 == 3 then
		if arg_5_2 == MainSwitchClassifyEnum.Classify.UI then
			arg_5_0:onTabSwitchOpen()
		else
			arg_5_0:onTabSwitchClose()
		end
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._lightspineparent = gohelper.findChild(arg_6_0.viewGO, "#go_spine_scale/lightspine")

	gohelper.setActive(arg_6_0._golightspinecontrol, false)

	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()

	arg_6_0:_initFrame()
end

function var_0_0._initFrame(arg_7_0)
	arg_7_0._frameBg = nil
	arg_7_0._frameSpineNode = nil
	arg_7_0._frameBg = var_0_1:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not arg_7_0._frameBg then
		logError("_initFrame no frameBg")
	end

	local var_7_0 = var_0_1:getSceneNode("s01_obj_a/Anim/Drawing/spine")

	if var_7_0 then
		arg_7_0._frameSpineNode = var_7_0.transform
	else
		logError("_initFrame no spineMountPoint")
	end

	gohelper.setActive(arg_7_0._frameBg, false)

	arg_7_0._frameSpineNodeX = 3.11
	arg_7_0._frameSpineNodeY = 0.51
	arg_7_0._frameSpineNodeZ = 3.09
	arg_7_0._frameSpineNodeScale = 0.39

	local var_7_1 = arg_7_0._frameBg:GetComponent(typeof(UnityEngine.Renderer))

	arg_7_0._frameBgMaterial = UnityEngine.Material.Instantiate(var_7_1.sharedMaterial)
	var_7_1.material = arg_7_0._frameBgMaterial
end

function var_0_0.onTabSwitchOpen(arg_8_0)
	arg_8_0:_showHero()
end

function var_0_0._showHero(arg_9_0)
	local var_9_0, var_9_1 = CharacterSwitchListModel.instance:getMainHero()

	if not arg_9_0._heroId or not arg_9_0._skinId or var_9_0 ~= arg_9_0._heroId or var_9_1 ~= arg_9_0._skinId then
		arg_9_0:_updateHero(var_9_0, var_9_1)

		return
	end

	arg_9_0:_onLightSpineLoaded()
end

function var_0_0._updateHero(arg_10_0, arg_10_1, arg_10_2)
	if gohelper.isNil(arg_10_0._golightspine) then
		return
	end

	if not arg_10_0._lightSpine then
		arg_10_0._lightSpine = LightModelAgent.Create(arg_10_0._golightspine, true)
	end

	arg_10_0._heroId, arg_10_0._skinId = arg_10_1, arg_10_2

	local var_10_0 = HeroConfig.instance:getHeroCO(arg_10_1)
	local var_10_1 = SkinConfig.instance:getSkinCo(arg_10_2 or var_10_0 and var_10_0.skin)

	arg_10_0._heroPhotoFrameBg = var_10_0.photoFrameBg
	arg_10_0._heroSkinConfig = var_10_1

	arg_10_0._lightSpine:setResPath(var_10_1, arg_10_0._onLightSpineLoaded, arg_10_0)
end

function var_0_0._onLightSpineLoaded(arg_11_0)
	arg_11_0:_setLightSpine()
	arg_11_0._lightSpine:play(StoryAnimName.B_IDLE, true)
end

function var_0_0._setLightSpine(arg_12_0)
	arg_12_0:_setOffset()
	gohelper.setActive(arg_12_0._golightspine, true)
end

function var_0_0.onTabSwitchClose(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._golightspine, false)
end

function var_0_0._setOffset(arg_14_0, arg_14_1)
	if gohelper.isNil(arg_14_0._golightspine) then
		return
	end

	local var_14_0 = SkinConfig.instance:getSkinOffset(arg_14_0._heroSkinConfig.mainViewOffset)
	local var_14_1 = arg_14_0._golightspine.transform
	local var_14_2 = tonumber(var_14_0[1])
	local var_14_3 = tonumber(var_14_0[2])
	local var_14_4 = tonumber(var_14_0[3])

	transformhelper.setLocalScale(var_14_1, var_14_4, var_14_4, var_14_4)
	recthelper.setAnchor(var_14_1, arg_14_1 and var_14_2 or var_14_2 - 1, arg_14_1 and var_14_3 or var_14_3 + 2.5)
end

function var_0_0._onSwitchUIVisible(arg_15_0, arg_15_1)
	arg_15_0:_setOffset(not arg_15_1)
end

function var_0_0.getLightSpineGo(arg_16_0)
	return arg_16_0._golightspine, arg_16_0._lightspineparent
end

function var_0_0.onClose(arg_17_0)
	gohelper.setActive(arg_17_0._golightspine, false)
end

return var_0_0
