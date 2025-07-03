module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationRoleItem", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationRoleItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._btnClick = gohelper.findChildButton(arg_1_0._go, "heroicon")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0._go, "#go_select")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0._go, "rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0._go, "heroicon")

	arg_1_0:addEvents()
end

function var_0_0.setClickCallBack(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._callBack = arg_2_1
	arg_2_0._callBackObj = arg_2_2
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnClick:AddClickListener(arg_3_0.onClickSelf, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnClick:RemoveClickListener()

	arg_4_0._callBack = nil
	arg_4_0._callBackObj = nil
end

function var_0_0._onLongClickItem(arg_5_0)
	if not arg_5_0._config then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = arg_5_0._config.heroId
	})
end

function var_0_0.onClickSelf(arg_6_0)
	logNormal("onClickChoice id = " .. tostring(arg_6_0._config.heroId))

	if arg_6_0._callBack and arg_6_0._callBackObj then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		arg_6_0._callBack(arg_6_0._callBackObj, arg_6_0._config.heroId)
	end
end

function var_0_0.setData(arg_7_0, arg_7_1)
	arg_7_0._config = arg_7_1

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = HeroConfig.instance:getHeroCO(arg_8_0._config.heroId)

	if not var_8_0 then
		logError("VersionActivity2_3NewCultivationRoleItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(arg_8_0._config.id))

		return
	end

	arg_8_0:refreshBaseInfo(var_8_0)
end

function var_0_0.refreshBaseInfo(arg_9_0, arg_9_1)
	local var_9_0 = SkinConfig.instance:getSkinCo(arg_9_1.skinId)

	if not var_9_0 then
		logError("VersionActivity2_3NewCultivationRoleItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(arg_9_1.skinId))

		return
	end

	arg_9_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(var_9_0.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_9_0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[arg_9_1.rare]))
end

function var_0_0.refreshSelect(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._config.heroId == arg_10_1

	gohelper.setActive(arg_10_0._goSelected, var_10_0)
end

function var_0_0.onDestroy(arg_11_0)
	if not arg_11_0._isDisposed then
		arg_11_0._simageicon:UnLoadImage()
		arg_11_0:removeEvents()

		arg_11_0._callBack = nil
		arg_11_0._isDisposed = true
	end
end

return var_0_0
