module("modules.logic.tower.view.fight.TowerDeepResultTeamItem", package.seeall)

local var_0_0 = class("TowerDeepResultTeamItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goNormalContent = gohelper.findChild(arg_1_0.go, "go_NormalContent")
	arg_1_0.goNormalRoot = gohelper.findChild(arg_1_0.go, "go_NormalContent/root")
	arg_1_0.animNormalRoot = arg_1_0.goNormalRoot:GetComponent(gohelper.Type_Animation)
	arg_1_0.goHeroNormalContent = gohelper.findChild(arg_1_0.go, "go_NormalContent/root/go_heroNormalContent")
	arg_1_0.goHeroItem = gohelper.findChild(arg_1_0.go, "go_NormalContent/root/go_heroNormalContent/go_heroitem")
	arg_1_0.txtNormalDepth = gohelper.findChildText(arg_1_0.go, "go_NormalContent/root/depth/txt_normalDepth")
	arg_1_0.goFinalContent = gohelper.findChild(arg_1_0.go, "go_FinalContent")
	arg_1_0.goFinalRoot = gohelper.findChild(arg_1_0.go, "go_FinalContent/root")
	arg_1_0.animFinalRoot = arg_1_0.goFinalRoot:GetComponent(gohelper.Type_Animation)
	arg_1_0.goHeroFinalContent = gohelper.findChild(arg_1_0.go, "go_FinalContent/root/go_heroFinalContent")
	arg_1_0.goHeroGroupItem = gohelper.findChild(arg_1_0.go, "go_FinalContent/root/go_heroFinalContent/group/go_herogroupitem")
	arg_1_0.txtFinalDepth = gohelper.findChildText(arg_1_0.go, "go_FinalContent/root/depth/txt_finalDepth")
	arg_1_0.goNewRecord = gohelper.findChild(arg_1_0.go, "go_FinalContent/root/depth/go_newRecord")
	arg_1_0.groupItemPosList = {}

	for iter_1_0 = 1, 4 do
		arg_1_0.groupItemPosList[iter_1_0] = gohelper.findChild(arg_1_0.go, "go_FinalContent/root/go_heroFinalContent/group/item" .. iter_1_0)
	end

	arg_1_0.finalHeroItemList = arg_1_0:getUserDataTb_()
	arg_1_0.normalHeroItemList = arg_1_0:getUserDataTb_()

	gohelper.setActive(arg_1_0.goHeroItem, false)
	gohelper.setActive(arg_1_0.goHeroGroupItem, false)

	arg_1_0.fightParam = FightModel.instance:getFightParam()
	arg_1_0.heroEquipMoList = arg_1_0.fightParam:getHeroEquipAndTrialMoList(true)
end

function var_0_0.refreshUI(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.teamData = arg_2_2[arg_2_1]

	gohelper.setActive(arg_2_0.go, true)

	arg_2_0.txtNormalDepth.text = string.format("%sM", arg_2_0.teamData.deep)
	arg_2_0.txtFinalDepth.text = string.format("%sM", arg_2_0.teamData.deep)
	arg_2_0.isFinalContent = arg_2_1 == #arg_2_2

	gohelper.setActive(arg_2_0.goNewRecord, arg_2_0.isFinalContent and TowerPermanentDeepModel.instance.isNewRecord)
	gohelper.setActive(arg_2_0.goNormalContent, not arg_2_0.isFinalContent)
	gohelper.setActive(arg_2_0.goFinalContent, arg_2_0.isFinalContent)
	recthelper.setWidth(arg_2_0.goNormalContent.transform, arg_2_1 % 2 == 0 and 0 or 80)

	if arg_2_0.isFinalContent then
		arg_2_0:createFinalHeroItem(arg_2_0.finalHeroItemList)
	else
		arg_2_0:createNormalHeroItem(arg_2_0.normalHeroItemList)
	end

	gohelper.setActive(arg_2_0.goNormalRoot, false)
	gohelper.setActive(arg_2_0.goFinalRoot, false)
end

function var_0_0.createNormalHeroItem(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.teamData.heroList

	for iter_3_0 = 1, 4 do
		local var_3_1 = arg_3_1[iter_3_0]

		if not var_3_1 then
			var_3_1 = {
				go = gohelper.clone(arg_3_0.goHeroItem, arg_3_0.goHeroNormalContent, "heroitem" .. iter_3_0)
			}
			var_3_1.simageRoleHead = gohelper.findChildSingleImage(var_3_1.go, "simage_rolehead")
			var_3_1.goEmpty = gohelper.findChild(var_3_1.go, "go_empty")
			arg_3_1[iter_3_0] = var_3_1
		end

		gohelper.setActive(var_3_1.go, true)

		local var_3_2 = var_3_0[iter_3_0]

		gohelper.setActive(var_3_1.goEmpty, not var_3_2)
		gohelper.setActive(var_3_1.simageRoleHead.gameObject, var_3_2)

		if var_3_2 then
			local var_3_3 = 0

			if var_3_2.trialId and var_3_2.trialId > 0 then
				var_3_3 = lua_hero_trial.configDict[var_3_2.trialId][0].skin
			elseif var_3_2.heroId and var_3_2.heroId > 0 then
				var_3_3 = HeroConfig.instance:getHeroCO(var_3_2.heroId).skinId
			end

			local var_3_4 = SkinConfig.instance:getSkinCo(var_3_3)

			var_3_1.simageRoleHead:LoadImage(ResUrl.getHeadIconSmall(var_3_4.retangleIcon))
		end
	end
end

function var_0_0.createFinalHeroItem(arg_4_0, arg_4_1)
	for iter_4_0 = 1, 4 do
		local var_4_0 = arg_4_1[iter_4_0]

		if not var_4_0 then
			var_4_0 = {
				go = gohelper.clone(arg_4_0.goHeroGroupItem, arg_4_0.groupItemPosList[iter_4_0], "heroitem" .. iter_4_0)
			}
			var_4_0.heroItemComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_0.go, TowerDeepResultHeroItem)
			arg_4_1[iter_4_0] = var_4_0
		end

		local var_4_1 = arg_4_0.heroEquipMoList[iter_4_0]

		if var_4_1 then
			var_4_0.heroItemComp:setData(var_4_1.heroMo, var_4_1.equipMo)
		else
			var_4_0.heroItemComp:setData()
		end
	end
end

function var_0_0.showTeamItem(arg_5_0, arg_5_1)
	TaskDispatcher.runDelay(arg_5_0.playShowAnim, arg_5_0, arg_5_1)
end

function var_0_0.playShowAnim(arg_6_0)
	gohelper.setActive(arg_6_0.goNormalRoot, not arg_6_0.isFinalContent)
	gohelper.setActive(arg_6_0.goFinalRoot, arg_6_0.isFinalContent)

	if arg_6_0.isFinalContent then
		arg_6_0.animFinalRoot:Play()
	else
		arg_6_0.animNormalRoot:Play()
	end
end

function var_0_0.onDestroy(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.normalHeroItemList) do
		iter_7_1.simageRoleHead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_7_0.playShowAnim, arg_7_0)
end

return var_0_0
