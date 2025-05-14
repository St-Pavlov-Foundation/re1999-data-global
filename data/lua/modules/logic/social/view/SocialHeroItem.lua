module("modules.logic.social.view.SocialHeroItem", package.seeall)

local var_0_0 = class("SocialHeroItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_1, "Role/#image_Rare")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_1, "Role/#image_Career")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_1, "Role/#simage_HeroIcon")
	arg_1_0._txtlv = gohelper.findChildTextMesh(arg_1_1, "Lv/#txt_Lv")

	for iter_1_0 = 1, 5 do
		arg_1_0["_goexSkillFull" .. iter_1_0] = gohelper.findChild(arg_1_1, "Lv/SuZao/" .. iter_1_0 .. "/FG")
	end

	arg_1_0._gorank = gohelper.findChild(arg_1_1, "Rank")

	for iter_1_1 = 1, 3 do
		arg_1_0["_gorank" .. iter_1_1] = gohelper.findChild(arg_1_0._gorank, "rank" .. iter_1_1)
	end
end

function var_0_0.setActive(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0.go, arg_2_1)
end

function var_0_0.updateMo(arg_3_0, arg_3_1)
	arg_3_0:setActive(true)

	local var_3_0 = arg_3_1.level
	local var_3_1 = arg_3_1.exSkillLevel
	local var_3_2 = lua_character.configDict[arg_3_1.heroId]
	local var_3_3 = arg_3_1.skin

	if var_3_3 == 0 then
		var_3_3 = var_3_2.skinId
	end

	local var_3_4 = lua_skin.configDict[var_3_3]
	local var_3_5, var_3_6 = HeroConfig.instance:getShowLevel(var_3_0)

	arg_3_0._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(var_3_4.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_3_0._imagecareer, "lssx_" .. tostring(var_3_2.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_3_0._imagerare, "bgequip" .. CharacterEnum.Star[var_3_2.rare])

	if var_3_6 == 1 then
		gohelper.setActive(arg_3_0._gorank, false)
	else
		gohelper.setActive(arg_3_0._gorank, true)

		for iter_3_0 = 1, 3 do
			gohelper.setActive(arg_3_0["_gorank" .. iter_3_0], iter_3_0 == var_3_6 - 1)
		end
	end

	for iter_3_1 = 1, 5 do
		gohelper.setActive(arg_3_0["_goexSkillFull" .. iter_3_1], iter_3_1 <= var_3_1)
	end

	arg_3_0._txtlv.text = "Lv." .. var_3_5
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._simageheroicon:UnLoadImage()
end

return var_0_0
