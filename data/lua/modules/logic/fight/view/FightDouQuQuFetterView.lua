module("modules.logic.fight.view.FightDouQuQuFetterView", package.seeall)

local var_0_0 = class("FightDouQuQuFetterView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.content = gohelper.findChild(arg_1_0.viewGO, "root/fetters/Viewport/Content")
	arg_1_0.itemObj = gohelper.findChild(arg_1_0.viewGO, "root/fetters/Viewport/Content/FetterItem")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onConstructor(arg_3_0, arg_3_1)
	arg_3_0.entityMO = arg_3_1
end

function var_0_0.refreshEntityMO(arg_4_0, arg_4_1)
	arg_4_0.entityMO = arg_4_1

	if arg_4_0.viewGO then
		arg_4_0:refreshFetter()
	end
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(lua_activity191_relation.configDict) do
		local var_5_1 = iter_5_1.tag

		var_5_0[var_5_1] = var_5_0[var_5_1] or {}

		table.insert(var_5_0[var_5_1], iter_5_1)
	end

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		table.sort(iter_5_3, function(arg_6_0, arg_6_1)
			return arg_6_0.activeNum < arg_6_1.activeNum
		end)
	end

	arg_5_0.configDic = var_5_0
	arg_5_0.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	arg_5_0:refreshFetter()
end

function var_0_0.refreshFetter(arg_7_0)
	local var_7_0 = arg_7_0.entityMO.side == FightEnum.EntitySide.MySide and arg_7_0.customData.teamATag2NumMap or arg_7_0.customData.teamBTag2NumMap

	if var_7_0 and tabletool.len(var_7_0) > 0 then
		gohelper.setActive(arg_7_0.viewGO, true)

		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			table.insert(var_7_1, {
				key = iter_7_0,
				value = iter_7_1
			})
		end

		for iter_7_2, iter_7_3 in ipairs(var_7_1) do
			for iter_7_4 = #arg_7_0.configDic[iter_7_3.key], 1, -1 do
				local var_7_2 = arg_7_0.configDic[iter_7_3.key][iter_7_4]

				if iter_7_3.value >= var_7_2.activeNum then
					iter_7_3.config = var_7_2

					if var_7_2.activeNum > 0 then
						iter_7_3.active = true
					end

					break
				end
			end
		end

		table.sort(var_7_1, var_0_0.sortItemListData)
		arg_7_0:com_createObjList(arg_7_0.onItemShow, var_7_1, arg_7_0.content, arg_7_0.itemObj)
	else
		gohelper.setActive(arg_7_0.viewGO, false)
	end
end

function var_0_0.sortItemListData(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.active
	local var_8_1 = arg_8_1.active

	if var_8_0 and not var_8_1 then
		return true
	elseif not var_8_0 and var_8_1 then
		return false
	else
		local var_8_2 = arg_8_0.config
		local var_8_3 = arg_8_1.config

		if var_8_2.level == var_8_3.level then
			if arg_8_0.value == arg_8_1.value then
				return var_8_2.id < var_8_3.id
			else
				return arg_8_0.value > arg_8_1.value
			end
		else
			return var_8_2.level > var_8_3.level
		end

		return false
	end
end

function var_0_0.onItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.findChildImage(arg_9_1, "image_Bg")
	local var_9_1 = gohelper.findChildImage(arg_9_1, "image_Fetter")
	local var_9_2 = gohelper.findChildText(arg_9_1, "txt_FetterCnt")
	local var_9_3 = arg_9_2.key
	local var_9_4 = arg_9_2.value
	local var_9_5 = Activity191Config.instance:getRelationMaxCo(var_9_3)
	local var_9_6 = 0
	local var_9_7 = var_9_5

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.configDic[var_9_3]) do
		if var_9_4 >= iter_9_1.activeNum then
			var_9_6 = iter_9_1.level
			var_9_7 = iter_9_1
		end
	end

	local var_9_8 = var_9_6 == 0 and "#ED7F7F" or "#F0E2CA"
	local var_9_9 = var_9_6 == 0 and "#838383" or "#F0E2CA"

	var_9_2.text = string.format("<%s>%s</color><%s>/%s</color>", var_9_8, var_9_4, var_9_9, var_9_5.activeNum)

	UISpriteSetMgr.instance:setAct174Sprite(var_9_0, "act174_shop_tag_" .. var_9_7.tagBg)
	ZProj.UGUIHelper.SetGrayscale(var_9_0.gameObject, var_9_6 == 0)
	Activity191Helper.setFetterIcon(var_9_1, var_9_7.icon)

	local var_9_10 = gohelper.getClickWithDefaultAudio(arg_9_1)
	local var_9_11 = {
		isFight = true,
		count = var_9_4,
		tag = var_9_7.tag
	}

	arg_9_0:com_registClick(var_9_10, arg_9_0.onClickItem, var_9_11)
end

function var_0_0.onClickItem(arg_10_0, arg_10_1)
	Activity191Controller.instance:openFetterTipView(arg_10_1)
end

return var_0_0
