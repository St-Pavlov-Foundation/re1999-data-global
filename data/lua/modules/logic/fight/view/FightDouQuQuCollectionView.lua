module("modules.logic.fight.view.FightDouQuQuCollectionView", package.seeall)

local var_0_0 = class("FightDouQuQuCollectionView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.collectionObjList = {}
	arg_1_0.simage_iconList = {}
	arg_1_0.img_rareList = {}

	for iter_1_0 = 1, 2 do
		table.insert(arg_1_0.collectionObjList, gohelper.findChild(arg_1_0.viewGO, "root/collection" .. iter_1_0))
		table.insert(arg_1_0.simage_iconList, gohelper.findChildSingleImage(arg_1_0.viewGO, "root/collection" .. iter_1_0 .. "/simage_Icon"))
		table.insert(arg_1_0.img_rareList, gohelper.findChildImage(arg_1_0.viewGO, "root/collection" .. iter_1_0 .. "/image_Rare"))
	end
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
		arg_4_0:refreshCollection()
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]

	arg_5_0:refreshCollection()
end

function var_0_0.refreshCollection(arg_6_0)
	local var_6_0 = arg_6_0.entityMO.side == FightEnum.EntitySide.MySide and arg_6_0.customData.teamAHeroInfo or arg_6_0.customData.teamBHeroInfo
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if tonumber(iter_6_0) == arg_6_0.entityMO.modelId then
			local var_6_2 = string.splitToNumber(iter_6_1, "#")

			for iter_6_2 = 2, #var_6_2 do
				local var_6_3 = tonumber(var_6_2[iter_6_2])

				if var_6_3 ~= 0 then
					table.insert(var_6_1, var_6_3)
				end
			end

			break
		end
	end

	if #var_6_1 == 0 then
		gohelper.setActive(arg_6_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_6_0.viewGO, true)

	for iter_6_3 = 1, #arg_6_0.collectionObjList do
		local var_6_4 = arg_6_0.collectionObjList[iter_6_3]
		local var_6_5 = var_6_1[iter_6_3]

		if var_6_5 then
			gohelper.setActive(var_6_4, true)

			local var_6_6 = Activity191Config.instance:getCollectionCo(var_6_5)

			UISpriteSetMgr.instance:setAct174Sprite(arg_6_0.img_rareList[iter_6_3], "act174_propitembg_" .. var_6_6.rare)
			arg_6_0.simage_iconList[iter_6_3]:LoadImage(ResUrl.getRougeSingleBgCollection(var_6_6.icon))

			local var_6_7 = gohelper.getClickWithDefaultAudio(var_6_4)

			arg_6_0:com_registClick(var_6_7, arg_6_0.onItemClick, var_6_5)
		else
			gohelper.setActive(var_6_4, false)
		end
	end
end

function var_0_0.onItemClick(arg_7_0, arg_7_1)
	local var_7_0 = false

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.customData.updateCollectionIds) do
		if iter_7_1 == arg_7_1 then
			var_7_0 = true

			break
		end
	end

	local var_7_1 = {
		itemId = arg_7_1,
		enhance = var_7_0
	}

	Activity191Controller.instance:openCollectionTipView(var_7_1)
end

return var_0_0
