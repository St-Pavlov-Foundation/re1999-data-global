module("modules.logic.playercard.view.PlayerCardCharacterSwitchSkinItem", package.seeall)

local var_0_0 = class("PlayerCardCharacterSwitchSkinItem", LuaCompBase)

function var_0_0.showSkin(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._heroId = arg_1_1
	arg_1_0._skinId = arg_1_2

	gohelper.setActive(arg_1_0.viewGO, true)

	arg_1_0._image = arg_1_0._singleImg:GetComponent(gohelper.Type_Image)
	arg_1_0._image.enabled = false

	arg_1_0._singleImg:LoadImage(ResUrl.getHeadIconMiddle(arg_1_2), arg_1_0._loadCallback, arg_1_0)
end

function var_0_0._loadCallback(arg_2_0)
	arg_2_0._image.enabled = true
end

function var_0_0.setSelected(arg_3_0, arg_3_1)
	arg_3_0._selected = arg_3_1

	gohelper.setActive(arg_3_0._selectGo, arg_3_1)
	gohelper.setActive(arg_3_0._unselectGo, not arg_3_1)

	arg_3_0._canvas.alpha = arg_3_1 and 1 or 0.75
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1
	arg_4_0._singleImg = gohelper.findChildSingleImage(arg_4_0.viewGO, "heroskin")
	arg_4_0._selectGo = gohelper.findChild(arg_4_0.viewGO, "heroskin/select")
	arg_4_0._unselectGo = gohelper.findChild(arg_4_0.viewGO, "heroskin/unselect")
	arg_4_0._canvas = gohelper.findChildComponent(arg_4_0.viewGO, "heroskin", typeof(UnityEngine.CanvasGroup))
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0._click = gohelper.getClickWithAudio(arg_5_0.viewGO, AudioEnum.UI.play_ui_character_switch)

	if arg_5_0._click then
		arg_5_0._click:AddClickListener(arg_5_0._onClick, arg_5_0)
	end

	PlayerCardController.instance:registerCallback(PlayerCardEvent.SwitchHeroSkin, arg_5_0._switchHeroSkin, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.SwitchHeroSkin, arg_6_0._switchHeroSkin, arg_6_0)

	if arg_6_0._click then
		arg_6_0._click:RemoveClickListener()
	end
end

function var_0_0._switchHeroSkin(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1 == arg_7_0._heroId and arg_7_0._skinId == arg_7_2

	arg_7_0:setSelected(var_7_0)
end

function var_0_0._onClick(arg_8_0)
	if arg_8_0._selected then
		return
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchHeroSkin, arg_8_0._heroId, arg_8_0._skinId)
end

function var_0_0.onStart(arg_9_0)
	return
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._singleImg:UnLoadImage()
end

return var_0_0
