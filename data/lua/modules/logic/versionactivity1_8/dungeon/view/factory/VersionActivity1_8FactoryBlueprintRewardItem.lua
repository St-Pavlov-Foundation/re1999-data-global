module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintRewardItem", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryBlueprintRewardItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform
	arg_1_0.componentId = arg_1_2

	if arg_1_3 then
		arg_1_0.progressPointLightGo = gohelper.findChild(arg_1_3, "light")
	end

	arg_1_0.actId = Activity157Model.instance:getActId()

	local var_1_0 = {}
	local var_1_1 = Activity157Config.instance:getComponentReward(arg_1_0.actId, arg_1_0.componentId)

	if not string.nilorempty(var_1_1) then
		var_1_0 = GameUtil.splitString2(var_1_1, true)
	end

	arg_1_0._rewardItemList = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_2 = gohelper.findChild(arg_1_0.go, "reward" .. iter_1_0)

		if var_1_2 then
			local var_1_3 = arg_1_0:getUserDataTb_()
			local var_1_4 = iter_1_1[1]
			local var_1_5 = iter_1_1[2]

			var_1_3.gohasget = gohelper.findChild(var_1_2, "#go_hasget")

			local var_1_6, var_1_7 = ItemModel.instance:getItemConfigAndIcon(var_1_4, var_1_5)

			if var_1_4 == MaterialEnum.MaterialType.Building then
				local var_1_8 = Activity157Config.instance:getComponentBonusBuildingLevel(arg_1_0.actId, arg_1_0.componentId)
				local var_1_9 = RoomConfig.instance:getLevelGroupConfig(var_1_5, var_1_8)

				if var_1_9 then
					var_1_7 = ResUrl.getRoomBuildingPropIcon(var_1_9.icon)
				end
			end

			var_1_3.simagereward = gohelper.findChildSingleImage(var_1_2, "#simage_reward")

			if var_1_7 then
				var_1_3.simagereward:LoadImage(var_1_7)
			end

			local var_1_10 = gohelper.findChildImage(var_1_2, "bg")

			if var_1_10 then
				local var_1_11 = var_1_6.rare

				UISpriteSetMgr.instance:setV1a8FactorySprite(var_1_10, "v1a8_dungeon_factory_rewardbg" .. var_1_11)
			end

			gohelper.findChildText(var_1_2, "#txt_rewardcount").text = luaLang("multiple") .. iter_1_1[3]

			table.insert(arg_1_0._rewardItemList, var_1_3)
		end
	end

	local var_1_12 = #var_1_0
	local var_1_13 = arg_1_0.trans.childCount

	if var_1_12 < var_1_13 then
		for iter_1_2 = var_1_12 + 1, var_1_13 do
			local var_1_14 = arg_1_0.trans:GetChild(iter_1_2 - 1)

			gohelper.setActive(var_1_14.gameObject, false)
		end
	end
end

function var_0_0.refresh(arg_2_0, arg_2_1)
	local var_2_0 = Activity157Model.instance:isRepairComponent(arg_2_0.componentId)
	local var_2_1 = Activity157Model.instance:hasComponentGotReward(arg_2_0.componentId)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._rewardItemList) do
		local var_2_2 = iter_2_1.gohasget

		gohelper.setActive(var_2_2, var_2_1)

		if arg_2_1 and var_2_0 and not var_2_1 then
			arg_2_0:playHasGetAnim(var_2_2)
		end
	end

	gohelper.setActive(arg_2_0.progressPointLightGo, var_2_1)
end

function var_0_0.playHasGetAnim(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_1, true)
	arg_3_1:GetComponent(typeof(UnityEngine.Animator)):Play("go_hasget_in")
end

function var_0_0.destroy(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._rewardItemList) do
		iter_4_1.simagereward:UnLoadImage()
	end

	arg_4_0:__onDispose()
end

return var_0_0
