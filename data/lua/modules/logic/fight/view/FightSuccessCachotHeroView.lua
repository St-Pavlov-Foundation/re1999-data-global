module("modules.logic.fight.view.FightSuccessCachotHeroView", package.seeall)

local var_0_0 = class("FightSuccessCachotHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_cachot_herogroup")
	arg_1_0._heroItemParent = gohelper.findChild(arg_1_0._goroot, "layout")
	arg_1_0._heroItem = gohelper.findChild(arg_1_0._goroot, "layout/heroitem")
	arg_1_0._txtLv = gohelper.findChild(arg_1_0.viewGO, "goalcontent/txtLv")
end

function var_0_0.onOpen(arg_2_0)
	gohelper.setActive(arg_2_0._txtLv, false)
	gohelper.setActive(arg_2_0._goroot, true)

	local var_2_0 = {}
	local var_2_1 = V1a6_CachotModel.instance:getTeamInfo()

	if not var_2_1 then
		return
	end

	local var_2_2 = var_2_1:getCurGroupInfo()

	if var_2_2 then
		for iter_2_0, iter_2_1 in ipairs(var_2_2.heroList) do
			local var_2_3 = HeroModel.instance:getById(iter_2_1)

			if var_2_3 then
				local var_2_4 = var_2_1:getHeroHp(var_2_3.heroId)

				if var_2_3.skin == 0 then
					local var_2_5 = lua_character.configDict[var_2_3.heroId].skinId
				end

				table.insert(var_2_0, {
					skinId = var_2_3.skin,
					nowHp = var_2_4.life / 1000,
					heroId = var_2_3.heroId
				})
			end
		end
	end

	gohelper.CreateObjList(arg_2_0, arg_2_0._onHeroItemCreate, var_2_0, arg_2_0._heroItemParent, arg_2_0._heroItem)
end

function var_0_0._onHeroItemCreate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = gohelper.findChildSlider(arg_3_1, "#slider_hp")
	local var_3_1 = gohelper.findChildSingleImage(arg_3_1, "hero/#simage_rolehead")
	local var_3_2 = gohelper.findChild(arg_3_1, "#dead")

	var_3_0:SetValue(arg_3_2.nowHp)
	gohelper.setActive(var_3_2, arg_3_2.nowHp <= 0)

	local var_3_3 = lua_skin.configDict[arg_3_2.skinId]

	var_3_1:LoadImage(ResUrl.getHeadIconSmall(var_3_3.headIcon))
	ZProj.UGUIHelper.SetGrayscale(var_3_1.gameObject, arg_3_2.nowHp <= 0)
end

function var_0_0.onClose(arg_4_0)
	return
end

return var_0_0
