module("modules.logic.playercard.view.StorePlayerCardView", package.seeall)

local var_0_0 = class("StorePlayerCardView", NewPlayerCardView)

function var_0_0.onOpen(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._achievementCls = arg_1_0._achievementCls or MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.viewGO, PlayerCardAchievement)
	arg_1_0._achievementCls.viewParam = arg_1_0.viewParam
	arg_1_0._achievementCls.viewContainer = arg_1_0.viewContainer

	arg_1_0._achievementCls:onOpen()

	arg_1_0._infoCls = arg_1_0._infoCls or MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.viewGO, PlayerCardPlayerInfo)
	arg_1_0._infoCls.viewParam = arg_1_0.viewParam

	arg_1_0._infoCls:onOpen()

	arg_1_0._loader = arg_1_0._loader or MultiAbLoader.New()
	arg_1_0._socialitemPath = "ui/viewres/social/socialfrienditem.prefab"
	arg_1_0._skinId = arg_1_2

	if not arg_1_0._socialitem then
		arg_1_0._loader:addPath(arg_1_0._socialitemPath)
		arg_1_0._loader:startLoad(arg_1_0._onLoadFinish, arg_1_0)
	else
		arg_1_0:_showSocialItem()
	end

	arg_1_0.viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:_onOpen(arg_1_1, arg_1_2)
end

function var_0_0._onOpen(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._animator.enabled = true

	if arg_2_0.viewParam and arg_2_0.viewParam.userId then
		arg_2_0.userId = arg_2_0.viewParam.userId
	end

	arg_2_0.playercardinfo = PlayerCardModel.instance:getCardInfo(arg_2_0.userId)

	local var_2_0 = arg_2_2 or arg_2_0.playercardinfo:getThemeId()

	if var_2_0 == 0 or string.nilorempty(var_2_0) then
		var_2_0 = nil
	end

	arg_2_0.themeId = var_2_0

	local var_2_1, var_2_2, var_2_3, var_2_4 = arg_2_0.playercardinfo:getMainHero()

	if arg_2_1 and arg_2_1 > 0 then
		var_2_2 = arg_2_1
	end

	arg_2_0:_creatBgEffect()

	local var_2_5 = SkinConfig.instance:getSkinCo(var_2_2).characterId

	arg_2_0:_updateHero(var_2_5, var_2_2)
	arg_2_0:_refreshProgress()
	arg_2_0:_refreshBaseInfo()
	arg_2_0:_initCritter()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

	arg_2_0.progressopen = false
	arg_2_0.baseinfoopen = false
end

function var_0_0._editableInitView(arg_3_0)
	var_0_0.super._editableInitView(arg_3_0)
	transformhelper.setLocalScale(arg_3_0._root.transform, 0.7, 0.7, 1)
	transformhelper.setLocalPosXY(arg_3_0._root.transform, 0, 40)
end

function var_0_0._onLoadFinish(arg_4_0)
	local var_4_0 = arg_4_0._loader:getAssetItem(arg_4_0._socialitemPath):GetResource(arg_4_0._socialitemPath)

	arg_4_0._socialitem = gohelper.clone(var_4_0, arg_4_0.viewGO)
	arg_4_0._socialfrienditemcls = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._socialitem, StorePlayerCardInfoItem)

	arg_4_0:_showSocialItem()
end

function var_0_0._showSocialItem(arg_5_0)
	if not arg_5_0._socialitem or not arg_5_0._socialfrienditemcls then
		return
	end

	local var_5_0 = PlayerModel.instance:getPlayinfo()
	local var_5_1 = {
		time = 0,
		userId = var_5_0.userId,
		name = var_5_0.name,
		level = var_5_0.level,
		portrait = var_5_0.portrait
	}

	arg_5_0._socialfrienditemcls:onUpdateMO(var_5_1)
	arg_5_0._socialfrienditemcls:selectSkin(arg_5_0._skinId)
	transformhelper.setLocalScale(arg_5_0._socialitem.transform, 0.75, 0.75, 1)
	transformhelper.setLocalPosXY(arg_5_0._socialitem.transform, 730, 150)
end

function var_0_0._disposeLoader(arg_6_0)
	if arg_6_0._loader then
		arg_6_0._loader:dispose()

		arg_6_0._loader = nil
	end
end

function var_0_0.onShowDecorateStoreDefault(arg_7_0)
	arg_7_0:playAnim("open", 1)

	if arg_7_0._socialfrienditemcls then
		arg_7_0._socialfrienditemcls:onShowDecorateStoreDefault()
	end
end

function var_0_0.playAnim(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0.viewAnim then
		arg_8_0.viewAnim:Play(arg_8_1, 0, arg_8_2)
	end
end

function var_0_0.onDestroy(arg_9_0)
	var_0_0.super.onDestroy(arg_9_0)
	arg_9_0:_disposeLoader()
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:resetSpine()
	arg_10_0:removeEvents()

	arg_10_0._has_onInitView = false

	if arg_10_0._scrollView then
		arg_10_0._scrollView:onDestroyViewInternal()
		arg_10_0._scrollView:__onDispose()
	end

	gohelper.destroy(arg_10_0.goskinpreview)

	arg_10_0._scrollView = nil
end

return var_0_0
