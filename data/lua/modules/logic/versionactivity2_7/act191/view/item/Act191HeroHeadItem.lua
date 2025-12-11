module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroHeadItem", package.seeall)

local var_0_0 = class("Act191HeroHeadItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	if arg_1_1 then
		arg_1_0.noFetter = arg_1_1.noFetter
		arg_1_0.showExSkill = arg_1_1.exSkill
		arg_1_0.noClick = arg_1_1.noClick
	end
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goequiped = gohelper.findChild(arg_2_1, "go_equiped")
	arg_2_0.gonormal = gohelper.findChild(arg_2_1, "go_normal")
	arg_2_0.simageIcon = gohelper.findChildSingleImage(arg_2_1, "go_normal/hero/simage_Icon")
	arg_2_0.goExSkill = gohelper.findChild(arg_2_1, "go_normal/hero/ExSkill")
	arg_2_0.imageExSkill = gohelper.findChildImage(arg_2_1, "go_normal/hero/ExSkill/bg/image_ExSkill")
	arg_2_0.imageRare = gohelper.findChildImage(arg_2_1, "go_normal/hero/image_Rare")
	arg_2_0.imageCareer = gohelper.findChildImage(arg_2_1, "go_normal/image_Career")
	arg_2_0.goTag = gohelper.findChild(arg_2_1, "go_normal/tag")

	gohelper.setActive(arg_2_0.goTag, not arg_2_0.noFetter)

	arg_2_0.item = gohelper.findChild(arg_2_1, "go_normal/tag/item")

	gohelper.setActive(arg_2_0.item, false)

	arg_2_0.gounown = gohelper.findChild(arg_2_1, "go_unown")
	arg_2_0.simageIconU = gohelper.findChildSingleImage(arg_2_1, "go_unown/hero/simage_Icon")
	arg_2_0.goMask = gohelper.findChild(arg_2_1, "go_unown/hero/mask")
	arg_2_0.imageRareU = gohelper.findChildImage(arg_2_1, "go_unown/hero/image_Rare")
	arg_2_0.imageCareerU = gohelper.findChildImage(arg_2_1, "go_unown/image_Career")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "btn_Click")

	gohelper.setActive(arg_2_0.btnClick, not arg_2_0.noClick)

	arg_2_0.goMaxRare = gohelper.findChild(arg_2_1, "go_normal/hero/Rare_effect")
	arg_2_0.fetterItemList = {}
	arg_2_0.extraEffect = gohelper.findChild(arg_2_1, "effect")
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnClick, arg_3_0.onClick, arg_3_0)
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 then
		arg_4_0.config = Activity191Config.instance:getRoleCo(arg_4_2)
	else
		local var_4_0 = Activity191Model.instance:getActInfo():getGameInfo():getHeroInfoInWarehouse(arg_4_1)

		if var_4_0 then
			arg_4_0.config = Activity191Config.instance:getRoleCoByNativeId(arg_4_1, var_4_0.star)
		end
	end

	if arg_4_0.config then
		local var_4_1 = Activity191Helper.getHeadIconSmall(arg_4_0.config)

		arg_4_0.simageIcon:LoadImage(var_4_1)
		UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageCareer, "lssx_" .. arg_4_0.config.career)
		UISpriteSetMgr.instance:setAct174Sprite(arg_4_0.imageRare, "act174_roleframe_" .. arg_4_0.config.quality)
		arg_4_0.simageIconU:LoadImage(var_4_1)
		UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageCareerU, "lssx_" .. arg_4_0.config.career)
		UISpriteSetMgr.instance:setAct174Sprite(arg_4_0.imageRareU, "act174_roleframe_" .. arg_4_0.config.quality)
		gohelper.setActive(arg_4_0.goMaxRare, arg_4_0.config.quality == 5)

		if arg_4_0.showExSkill and arg_4_0.config.exLevel ~= 0 then
			local var_4_2 = arg_4_0.config.exLevel

			arg_4_0.imageExSkill.fillAmount = var_4_2 / CharacterEnum.MaxSkillExLevel

			gohelper.setActive(arg_4_0.goExSkill, true)
			gohelper.setActive(arg_4_0.goMask, true)
		else
			gohelper.setActive(arg_4_0.goExSkill, false)
			gohelper.setActive(arg_4_0.goMask, true)
		end

		arg_4_0:refreshFetter()
	end
end

function var_0_0.refreshFetter(arg_5_0)
	if arg_5_0.noFetter then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.fetterItemList) do
		gohelper.setActive(iter_5_1.go, false)
	end

	local var_5_0 = string.split(arg_5_0.config.tag, "#")

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		local var_5_1 = Activity191Config.instance:getRelationCo(iter_5_3)

		if var_5_1 then
			local var_5_2 = arg_5_0.fetterItemList[iter_5_2]

			if not var_5_2 then
				var_5_2 = arg_5_0:getUserDataTb_()
				var_5_2.go = gohelper.cloneInPlace(arg_5_0.item)
				var_5_2.icon = gohelper.findChildImage(var_5_2.go, "icon")
				arg_5_0.fetterItemList[iter_5_2] = var_5_2
			end

			Activity191Helper.setFetterIcon(var_5_2.icon, var_5_1.icon)
			gohelper.setActive(var_5_2.go, true)
		end
	end
end

function var_0_0.onClick(arg_6_0)
	if arg_6_0._overrideClick then
		arg_6_0._overrideClick(arg_6_0._overrideClickObj, arg_6_0._clickParam)

		return
	end

	local var_6_0 = {
		preview = arg_6_0.preview,
		heroList = {
			arg_6_0.config.id
		}
	}

	Activity191Controller.instance:openHeroTipView(var_6_0)
end

function var_0_0.setActivation(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0.goequiped, arg_7_1)
end

function var_0_0.setNotOwn(arg_8_0)
	gohelper.setActive(arg_8_0.gonormal, false)
	gohelper.setActive(arg_8_0.gounown, true)
end

function var_0_0.setOverrideClick(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0._overrideClick = arg_9_1
	arg_9_0._overrideClickObj = arg_9_2
	arg_9_0._clickParam = arg_9_3
end

function var_0_0.setPreview(arg_10_0)
	arg_10_0.preview = true
end

function var_0_0.setExtraEffect(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0.extraEffect, arg_11_1)
end

return var_0_0
