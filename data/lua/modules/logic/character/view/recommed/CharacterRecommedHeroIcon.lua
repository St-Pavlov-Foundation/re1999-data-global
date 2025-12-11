module("modules.logic.character.view.recommed.CharacterRecommedHeroIcon", package.seeall)

local var_0_0 = class("CharacterRecommedHeroIcon", ListScrollCell)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobossEmpty = gohelper.findChild(arg_1_0.viewGO, "go_empty")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "go_container")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_container/simage_heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "go_container/image_career")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "go_container/rare")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "go_container/#go_selected")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "clickarea")

	arg_1_0._btnclick = SLFramework.UGUI.UIClickListener.Get(var_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if arg_4_0._clickCB and arg_4_0._clickCBobj then
		arg_4_0._clickCB(arg_4_0._clickCBobj)
	end
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1

	arg_5_0:onInitView()
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goselected, false)
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	arg_9_0:_refreshHero()
end

function var_0_0._refreshHero(arg_10_0)
	local var_10_0 = arg_10_0._mo:getHeroConfig()
	local var_10_1 = arg_10_0._mo:getHeroSkinConfig()

	arg_10_0._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(var_10_1.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0._imagecareer, "lssx_" .. tostring(var_10_0.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0._imagerare, "equipbar" .. CharacterEnum.Color[var_10_0.rare])
end

function var_0_0.SetGrayscale(arg_11_0, arg_11_1)
	ZProj.UGUIHelper.SetGrayscale(arg_11_0._simageheroicon.gameObject, arg_11_1)
	ZProj.UGUIHelper.SetGrayscale(arg_11_0._imagecareer.gameObject, arg_11_1)
end

function var_0_0.setClickCallback(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._clickCB = arg_12_1
	arg_12_0._clickCBobj = arg_12_2
end

function var_0_0.onSelect(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goselected, arg_13_1)
end

function var_0_0.onDestroy(arg_14_0)
	return
end

return var_0_0
