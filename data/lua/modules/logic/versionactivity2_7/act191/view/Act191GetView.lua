module("modules.logic.versionactivity2_7.act191.view.Act191GetView", package.seeall)

local var_0_0 = class("Act191GetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollGet = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Get")
	arg_1_0._goHeroRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_Get/Viewport/Content/#go_HeroRoot")
	arg_1_0._goHero = gohelper.findChild(arg_1_0.viewGO, "#scroll_Get/Viewport/Content/#go_HeroRoot/#go_Hero")
	arg_1_0._goCollectionRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_Get/Viewport/Content/#go_CollectionRoot")
	arg_1_0._goCollection = gohelper.findChild(arg_1_0.viewGO, "#scroll_Get/Viewport/Content/#go_CollectionRoot/collectionitem/#go_Collection")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0.actInfo = Activity191Model.instance:getActInfo()
	arg_3_0.gameInfo = arg_3_0.actInfo:getGameInfo()
	arg_3_0.touchGraphic = arg_3_0._scrollGet.gameObject:GetComponent(typeof(UnityEngine.UI.Graphic))
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.actInfo.triggerEffectPushList) do
		if iter_4_1.effectId[1] and not string.nilorempty(iter_4_1.param) then
			local var_4_2 = lua_activity191_effect.configDict[iter_4_1.effectId[1]]

			if var_4_2 then
				local var_4_3

				if var_4_2.type == Activity191Enum.EffectType.Hero or var_4_2.type == Activity191Enum.EffectType.HeroByHero or var_4_2.type == Activity191Enum.EffectType.HeroByTag then
					var_4_3 = var_4_0
				elseif var_4_2.type == Activity191Enum.EffectType.Item or var_4_2.type == Activity191Enum.EffectType.ItemByItem or var_4_2.type == Activity191Enum.EffectType.ItemByTag then
					var_4_3 = var_4_1
				end

				if var_4_3 then
					local var_4_4 = cjson.decode(iter_4_1.param)

					for iter_4_2, iter_4_3 in ipairs(var_4_4) do
						if var_4_3[iter_4_3] then
							var_4_3[iter_4_3] = var_4_3[iter_4_3] + 1
						else
							var_4_3[iter_4_3] = 1
						end
					end
				end
			end
		end
	end

	local var_4_5 = {}
	local var_4_6 = {}

	for iter_4_4, iter_4_5 in pairs(var_4_0) do
		var_4_5[#var_4_5 + 1] = Activity191Config.instance:getRoleCo(iter_4_4)
	end

	for iter_4_6, iter_4_7 in pairs(var_4_1) do
		var_4_6[#var_4_6 + 1] = Activity191Config.instance:getCollectionCo(iter_4_6)
	end

	for iter_4_8 = 1, #var_4_5 do
		local var_4_7 = var_4_5[iter_4_8]
		local var_4_8 = gohelper.cloneInPlace(arg_4_0._goHero)
		local var_4_9 = gohelper.findChild(var_4_8, "head")
		local var_4_10 = arg_4_0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_4_9)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_4_10, Act191HeroHeadItem, {
			exSkill = true
		}):setData(var_4_7.roleId)

		local var_4_11 = gohelper.findChild(var_4_8, "go_lvlup")
		local var_4_12 = arg_4_0.gameInfo:getHeroInfoInWarehouse(var_4_7.roleId)
		local var_4_13 = 0

		if var_4_12 then
			local var_4_14 = var_4_0[var_4_7.id]

			var_4_13 = var_4_12.star ~= var_4_14 and var_4_14 or var_4_14 - 1
		end

		gohelper.setActive(var_4_11, var_4_13 ~= 0)

		local var_4_15 = lua_activity191_template.configDict[var_4_7.id]
		local var_4_16 = var_4_13 == 0 and "#C3AA87" or "#E27444"

		for iter_4_9 = 1, 5 do
			if iter_4_9 ~= 3 then
				local var_4_17 = gohelper.findChild(var_4_8, "go_attribute/attribute" .. iter_4_9)
				local var_4_18 = gohelper.findChildText(var_4_17, "txt_attribute")
				local var_4_19 = gohelper.findChild(var_4_17, "txt_attribute/go_up")

				gohelper.setActive(var_4_19, var_4_13 ~= 0)

				local var_4_20 = gohelper.findChildText(var_4_17, "name")
				local var_4_21 = Activity191Enum.AttrIdList[iter_4_9]
				local var_4_22 = var_4_15[Activity191Config.AttrIdToFieldName[var_4_21]]

				var_4_18.text = string.format("<color=%s>%s</color>", var_4_16, var_4_22)
				var_4_20.text = HeroConfig.instance:getHeroAttributeCO(var_4_21).name
			end
		end

		local var_4_23 = gohelper.findChildButtonWithAudio(var_4_8, "btn_Click")

		arg_4_0:addClickCb(var_4_23, arg_4_0.onClickHero, arg_4_0, var_4_7.id)
	end

	for iter_4_10 = 1, #var_4_6 do
		local var_4_24 = var_4_6[iter_4_10]

		for iter_4_11 = 1, var_4_1[var_4_24.id] do
			local var_4_25 = gohelper.cloneInPlace(arg_4_0._goCollection)
			local var_4_26 = gohelper.findChildImage(var_4_25, "image_Rare")

			UISpriteSetMgr.instance:setAct174Sprite(var_4_26, "act174_propitembg_" .. var_4_24.rare)
			gohelper.findChildSingleImage(var_4_25, "simage_Icon"):LoadImage(ResUrl.getRougeSingleBgCollection(var_4_24.icon))

			local var_4_27 = gohelper.findChildButtonWithAudio(var_4_25, "btn_Click")

			arg_4_0:addClickCb(var_4_27, arg_4_0.onClickCollection, arg_4_0, var_4_24.id)
		end
	end

	gohelper.setActive(arg_4_0._goHero, false)
	gohelper.setActive(arg_4_0._goCollection, false)
	gohelper.setActive(arg_4_0._goHeroRoot, #var_4_5 ~= 0)
	gohelper.setActive(arg_4_0._goCollectionRoot, #var_4_6 ~= 0)

	arg_4_0.touchGraphic.raycastTarget = #var_4_5 > 2
end

function var_0_0.onClose(arg_5_0)
	arg_5_0.actInfo:clearTriggerEffectPush()
	Activity191Controller.instance:nextStep()
end

function var_0_0.onClickHero(arg_6_0, arg_6_1)
	local var_6_0 = {
		heroList = {
			arg_6_1
		}
	}

	Activity191Controller.instance:openHeroTipView(var_6_0)
end

function var_0_0.onClickCollection(arg_7_0, arg_7_1)
	Activity191Controller.instance:openCollectionTipView({
		itemId = arg_7_1
	})
end

return var_0_0
