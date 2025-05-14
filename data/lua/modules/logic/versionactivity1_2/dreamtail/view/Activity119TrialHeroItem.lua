module("modules.logic.versionactivity1_2.dreamtail.view.Activity119TrialHeroItem", package.seeall)

local var_0_0 = class("Activity119TrialHeroItem")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.index = arg_1_2

	arg_1_0:onInitView()
	arg_1_0:addEvents()
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btn = gohelper.findButtonWithAudio(arg_2_0.go)
	arg_2_0._quality = gohelper.findChildImage(arg_2_0.go, "quality")
	arg_2_0._career = gohelper.findChildImage(arg_2_0.go, "career")
	arg_2_0._icon = gohelper.findChildSingleImage(arg_2_0.go, "mask/icon")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btn:AddClickListener(arg_3_0.onClickHero, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btn:RemoveClickListener()
end

function var_0_0.updateMO(arg_5_0)
	local var_5_0 = HeroGroupTrialModel.instance:getByIndex(arg_5_0.index)

	arg_5_0._mo = var_5_0

	local var_5_1 = SkinConfig.instance:getSkinCo(var_5_0.config.skinId)

	arg_5_0._icon:LoadImage(ResUrl.getRoomHeadIcon(var_5_1.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_5_0._quality, "bgequip" .. tostring(ItemEnum.Color[var_5_0.config.rare]))
	UISpriteSetMgr.instance:setCommonSprite(arg_5_0._career, "lssx_" .. tostring(var_5_0.config.career))
end

function var_0_0.onClickHero(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)
	CharacterController.instance:openCharacterView(arg_6_0._mo, HeroGroupTrialModel.instance:getList())
end

function var_0_0.dispose(arg_7_0)
	arg_7_0:removeEvents()

	arg_7_0.go = nil
	arg_7_0.index = nil
	arg_7_0._quality = nil

	arg_7_0._icon:UnLoadImage()

	arg_7_0._icon = nil
end

return var_0_0
