module("modules.logic.fight.view.FightEnemyActionCardItem", package.seeall)

local var_0_0 = class("FightEnemyActionCardItem", UserDataDispose)

function var_0_0.get(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.__onInit(arg_2_0)

	arg_2_0.goCard = arg_2_1
	arg_2_0.tr = arg_2_1.transform
	arg_2_0.cardMo = arg_2_2
	arg_2_0.skillId = arg_2_2.skillId
	arg_2_0.entityId = arg_2_2.uid
	arg_2_0.entityMo = FightDataHelper.entityMgr:getById(arg_2_0.entityId)
	arg_2_0.skillCo = lua_skill.configDict[arg_2_0.skillId]
	arg_2_0.skillCardLv = FightCardDataHelper.getSkillLv(arg_2_0.entityId, arg_2_0.skillId)
	arg_2_0.lvGoList = arg_2_0:getUserDataTb_()
	arg_2_0.lvImgIconList = arg_2_0:getUserDataTb_()
	arg_2_0.lvImgCompList = arg_2_0:getUserDataTb_()
	arg_2_0.starItemCanvasList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 0, 4 do
		local var_2_0 = gohelper.findChild(arg_2_0.goCard, "lv" .. iter_2_0)
		local var_2_1 = gohelper.findChildSingleImage(var_2_0, "imgIcon")
		local var_2_2 = gohelper.findChildImage(var_2_0, "imgIcon")

		gohelper.setActive(var_2_0, true)

		arg_2_0.lvGoList[iter_2_0] = var_2_0
		arg_2_0.lvImgIconList[iter_2_0] = var_2_1
		arg_2_0.lvImgCompList[iter_2_0] = var_2_2
	end

	arg_2_0.goTag = gohelper.findChild(arg_2_0.goCard, "tag")
	arg_2_0.tagPosLevelDic = {}

	for iter_2_1 = 0, 4 do
		local var_2_3, var_2_4 = recthelper.getAnchor(gohelper.findChild(arg_2_0.goCard, "tag/pos" .. iter_2_1).transform)

		arg_2_0.tagPosLevelDic[iter_2_1] = {
			var_2_3,
			var_2_4
		}
	end

	arg_2_0.tagRootTr = gohelper.findChild(arg_2_0.goCard, "tag/tag").transform
	arg_2_0.tagIcon = gohelper.findChildSingleImage(arg_2_0.goCard, "tag/tag/tagIcon")
	arg_2_0.starGo = gohelper.findChild(arg_2_0.goCard, "star")
	arg_2_0.starCanvas = gohelper.onceAddComponent(arg_2_0.starGo, typeof(UnityEngine.CanvasGroup))
	arg_2_0.innerStartGoList = arg_2_0:getUserDataTb_()
	arg_2_0.innerStartCanvasList = arg_2_0:getUserDataTb_()

	for iter_2_2 = 1, FightEnum.MaxSkillCardLv do
		local var_2_5 = gohelper.findChild(arg_2_0.goCard, "star/star" .. iter_2_2)

		table.insert(arg_2_0.innerStartGoList, var_2_5)
		table.insert(arg_2_0.innerStartCanvasList, gohelper.onceAddComponent(var_2_5, typeof(UnityEngine.CanvasGroup)))
	end

	arg_2_0:hideOther()
end

function var_0_0.hideOther(arg_3_0)
	local var_3_0 = gohelper.onceAddComponent(arg_3_0.goCard, typeof(UnityEngine.Animator))

	if var_3_0 then
		var_3_0.enabled = false
	end

	local var_3_1 = arg_3_0.tr.childCount

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = arg_3_0.tr:GetChild(iter_3_0 - 1)

		gohelper.setActive(var_3_2.gameObject, false)
	end
end

function var_0_0.refreshCard(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.lvGoList) do
		gohelper.setActive(iter_4_1, true)
		gohelper.setActiveCanvasGroup(iter_4_1, arg_4_0.skillCardLv == iter_4_0)
	end

	local var_4_0 = ResUrl.getSkillIcon(arg_4_0.skillCo.icon)

	for iter_4_2, iter_4_3 in pairs(arg_4_0.lvImgIconList) do
		if gohelper.isNil(arg_4_0.lvImgCompList[iter_4_2].sprite) then
			iter_4_3:UnLoadImage()
		elseif iter_4_3.curImageUrl ~= var_4_0 then
			iter_4_3:UnLoadImage()
		end

		iter_4_3:LoadImage(var_4_0)
	end

	local var_4_1 = arg_4_0.skillCardLv < FightEnum.UniqueSkillCardLv and arg_4_0.skillCardLv > 0

	gohelper.setActive(arg_4_0.starGo, var_4_1)

	arg_4_0.starCanvas.alpha = 1

	for iter_4_4, iter_4_5 in ipairs(arg_4_0.innerStartGoList) do
		gohelper.setActive(iter_4_5, iter_4_4 == arg_4_0.skillCardLv)

		if arg_4_0.innerStartCanvasList[iter_4_4] then
			arg_4_0.innerStartCanvasList[iter_4_4].alpha = 1
		end
	end

	gohelper.setActive(arg_4_0.goTag, true)
	arg_4_0.tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. arg_4_0.skillCo.showTag))

	local var_4_2 = arg_4_0.tagPosLevelDic[arg_4_0.skillCardLv]

	if var_4_2 then
		recthelper.setAnchor(arg_4_0.tagRootTr, var_4_2[1], var_4_2[2])
	end

	gohelper.setActive(arg_4_0.tagIcon.gameObject, arg_4_0.skillCardLv < FightEnum.UniqueSkillCardLv)
end

function var_0_0.refreshSelect(arg_5_0, arg_5_1)
	arg_5_0.select = arg_5_1
end

function var_0_0.destroy(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.lvImgIconList) do
		iter_6_1:UnLoadImage()
	end

	arg_6_0.tagIcon:UnLoadImage()
	var_0_0.super.__onDispose(arg_6_0)
end

return var_0_0
