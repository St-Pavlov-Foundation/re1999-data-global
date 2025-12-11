module("modules.logic.character.view.recommed.CharacterRecommedHeroView", package.seeall)

local var_0_0 = class("CharacterRecommedHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "left/hero/#go_spine")
	arg_1_0._gospineroot = gohelper.findChild(arg_1_0.viewGO, "left/hero")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, arg_2_0._refreshHero, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, arg_2_0._onJumpView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenViewCallBack, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_2_0.onOpenViewCallBack, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0.onCloseViewCallBack, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, arg_3_0._refreshHero, arg_3_0)
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnJumpView, arg_3_0._onJumpView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0.onOpenViewCallBack, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_3_0.onOpenViewCallBack, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0.onCloseViewCallBack, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	transformhelper.setLocalScale(arg_4_0._gospine.transform, 1, 1, 1)
	recthelper.setAnchor(arg_4_0._gospine.transform, -200, -1174)
end

function var_0_0.onOpen(arg_5_0)
	if arg_5_0.viewParam.uiSpine then
		arg_5_0._uiSpine = arg_5_0.viewParam.uiSpine
		arg_5_0._spineGo = arg_5_0._uiSpine._go.transform.parent
		arg_5_0._rootParent = arg_5_0._spineGo.transform.parent
	end

	arg_5_0:_refreshHero(arg_5_0.viewParam.heroId)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:_refreshHero(arg_6_0.viewParam.heroId)
end

function var_0_0._showSpine(arg_7_0, arg_7_1)
	if not arg_7_0._spineGo then
		return
	end

	local var_7_0
	local var_7_1

	if arg_7_1 then
		gohelper.addChildPosStay(arg_7_0._gospineroot, arg_7_0._spineGo)
		arg_7_0._uiSpine:setModelVisible(true)
		gohelper.setActive(arg_7_0._spineGo, true)

		var_7_0, var_7_1 = -69, 0
	else
		if not arg_7_0._rootParent then
			return
		end

		gohelper.addChildPosStay(arg_7_0._rootParent, arg_7_0._spineGo)

		var_7_0, var_7_1 = -69, -1174
	end

	recthelper.setAnchor(arg_7_0._spineGo.transform, var_7_0, var_7_1)
	transformhelper.setLocalScale(arg_7_0._spineGo.transform, 1, 1, 1)
end

function var_0_0.onOpenViewCallBack(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.HeroGroupPresetEditView then
		gohelper.setActive(arg_8_0._gospineroot, false)
	elseif arg_8_1 == ViewName.CharacterView then
		arg_8_0:_showSpine(false)
		arg_8_0:closeThis()
	end
end

function var_0_0.onCloseViewCallBack(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.HeroGroupPresetEditView then
		gohelper.setActive(arg_9_0._gospineroot, true)
	end
end

function var_0_0._onJumpView(arg_10_0, arg_10_1)
	if arg_10_1 == CharacterRecommedEnum.JumpView.Rank then
		arg_10_0:_showSpine(false)
	end
end

function var_0_0._refreshHero(arg_11_0, arg_11_1)
	if arg_11_0._heroId == arg_11_1 then
		arg_11_0:_showSpine(true)

		return
	end

	arg_11_0._heroId = arg_11_1
	arg_11_0._heroRecommendMo = CharacterRecommedModel.instance:getHeroRecommendMo(arg_11_1)
	arg_11_0._heroSkinConfig = arg_11_0._heroRecommendMo:getHeroSkinConfig()

	arg_11_0:_updateHero()
	arg_11_0:_setHeroTransform()
end

function var_0_0._setHeroTransform(arg_12_0)
	local var_12_0 = SkinConfig.instance:getSkinOffset(arg_12_0._heroSkinConfig.characterViewOffset)
	local var_12_1 = tonumber(var_12_0[3])

	if arg_12_0._spineGo then
		recthelper.setAnchor(arg_12_0._uiSpine._go.transform, tonumber(var_12_0[1]), tonumber(var_12_0[2]))
		transformhelper.setLocalScale(arg_12_0._uiSpine._go.transform, var_12_1, var_12_1, var_12_1)
	else
		recthelper.setAnchor(arg_12_0._gospine.transform, tonumber(var_12_0[1]), tonumber(var_12_0[2]))
		transformhelper.setLocalScale(arg_12_0._gospine.transform, var_12_1, var_12_1, var_12_1)
	end
end

function var_0_0._updateHero(arg_13_0)
	arg_13_0._isNeedDestory = false

	if arg_13_0._uiSpine then
		arg_13_0._uiSpine:onDestroy()
		arg_13_0._uiSpine:stopVoice()

		local var_13_0 = arg_13_0._uiSpine._go

		arg_13_0._uiSpine = nil
		arg_13_0._uiSpine = GuiModelAgent.Create(var_13_0, true)
	else
		arg_13_0._uiSpine = GuiModelAgent.Create(arg_13_0._gospine, true)

		arg_13_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_13_0.viewName)

		arg_13_0._isNeedDestory = true
	end

	arg_13_0:_loadSpine()
end

function var_0_0._loadSpine(arg_14_0)
	arg_14_0._uiSpine:setResPath(arg_14_0._heroSkinConfig, arg_14_0._onSpineLoaded, arg_14_0)
end

function var_0_0._onSpineLoaded(arg_15_0)
	arg_15_0._spineLoaded = true

	arg_15_0:_showSpine(true)
end

function var_0_0.onClose(arg_16_0, arg_16_1)
	if not arg_16_1 then
		arg_16_0:_showSpine(false)
	end
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0._uiSpine and arg_17_0._isNeedDestory then
		arg_17_0._uiSpine:onDestroy()

		arg_17_0._uiSpine = nil
	end
end

return var_0_0
