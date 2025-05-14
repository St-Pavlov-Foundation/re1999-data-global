module("modules.logic.versionactivity2_3.act174.view.Act174HeroItem", package.seeall)

local var_0_0 = class("Act174HeroItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._teamView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._goHero = gohelper.findChild(arg_2_1, "go_Hero")
	arg_2_0._heroIcon = gohelper.findChildSingleImage(arg_2_1, "go_Hero/image_Hero")
	arg_2_0._heroQuality = gohelper.findChildImage(arg_2_1, "go_Hero/image_quality")
	arg_2_0._heroCareer = gohelper.findChildImage(arg_2_1, "go_Hero/image_Career")
	arg_2_0._goEquip = gohelper.findChild(arg_2_1, "go_Equip")
	arg_2_0._skillIcon = gohelper.findChildSingleImage(arg_2_1, "go_Equip/skill/image_Skill")
	arg_2_0._collectionIcon = gohelper.findChildSingleImage(arg_2_1, "go_Equip/collection/image_Collection")
	arg_2_0._goEmptyCollection = gohelper.findChild(arg_2_1, "go_Equip/collection/empty")
	arg_2_0._goEmpty = gohelper.findChild(arg_2_1, "go_Empty")
	arg_2_0._txtNum = gohelper.findChildText(arg_2_1, "Index/txt_Num")
	arg_2_0._goLock = gohelper.findChild(arg_2_1, "go_Lock")
	arg_2_0.btnClick = gohelper.findButtonWithAudio(arg_2_1)

	CommonDragHelper.instance:registerDragObj(arg_2_1, arg_2_0.beginDrag, nil, arg_2_0.endDrag, arg_2_0.checkDrag, arg_2_0)
	gohelper.setActive(arg_2_0._goEmpty, true)
	gohelper.setActive(arg_2_0._goHero, false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0.btnClick:AddClickListener(arg_3_0.onClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0.btnClick:RemoveClickListener()
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0._heroIcon:UnLoadImage()
	arg_5_0._skillIcon:UnLoadImage()
	arg_5_0._collectionIcon:UnLoadImage()
	CommonDragHelper.instance:unregisterDragObj(arg_5_0._go)
end

function var_0_0.onClick(arg_6_0)
	if arg_6_0.tweenId or arg_6_0.isDraging then
		return
	end

	arg_6_0._teamView:clickHero(arg_6_0._index)
end

function var_0_0.setIndex(arg_7_0, arg_7_1)
	arg_7_0._index = arg_7_1

	local var_7_0, var_7_1 = Activity174Helper.CalculateRowColumn(arg_7_1)

	arg_7_0._txtNum.text = var_7_1

	local var_7_2 = arg_7_0._teamView.unLockTeamCnt

	gohelper.setActive(arg_7_0._goLock, var_7_2 < var_7_0)
	gohelper.setActive(arg_7_0._goEquip, var_7_0 <= var_7_2)
end

function var_0_0.setData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._heroId = arg_8_1
	arg_8_0._itemId = arg_8_2
	arg_8_0._skillIndex = arg_8_3

	if arg_8_1 then
		local var_8_0 = Activity174Config.instance:getRoleCo(arg_8_1)
		local var_8_1 = ResUrl.getHeadIconMiddle(var_8_0.skinId)

		arg_8_0._heroIcon:LoadImage(var_8_1)
		UISpriteSetMgr.instance:setAct174Sprite(arg_8_0._heroQuality, "act174_ready_rolebg_" .. var_8_0.rare)
		UISpriteSetMgr.instance:setCommonSprite(arg_8_0._heroCareer, "lssx_" .. var_8_0.career)
	end

	if arg_8_2 then
		local var_8_2 = lua_activity174_collection.configDict[arg_8_2]

		arg_8_0._collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_8_2.icon))
	end

	if arg_8_3 then
		local var_8_3 = Activity174Config.instance:getHeroSkillIdDic(arg_8_0._heroId, true)[arg_8_3]
		local var_8_4 = lua_skill.configDict[var_8_3]

		arg_8_0._skillIcon:LoadImage(ResUrl.getSkillIcon(var_8_4.icon))
	end

	gohelper.setActive(arg_8_0._goHero, arg_8_1)
	gohelper.setActive(arg_8_0._collectionIcon, arg_8_2)
	gohelper.setActive(arg_8_0._goEmptyCollection, not arg_8_2)
	gohelper.setActive(arg_8_0._skillIcon, arg_8_3)
	gohelper.setActive(arg_8_0._goEmpty, not arg_8_1 and not arg_8_2)
end

function var_0_0.activeEquip(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goEquip, arg_9_1)
end

function var_0_0.beginDrag(arg_10_0)
	gohelper.setAsLastSibling(arg_10_0._go)

	arg_10_0.isDraging = true
end

function var_0_0.endDrag(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.isDraging = false

	local var_11_0 = arg_11_2.position
	local var_11_1 = arg_11_0:findTarget(var_11_0)

	if not var_11_1 then
		local var_11_2 = arg_11_0._teamView.frameTrList[arg_11_0._index]
		local var_11_3, var_11_4 = recthelper.getAnchor(var_11_2)

		arg_11_0:setToPos(arg_11_0._go.transform, Vector2(var_11_3, var_11_4), true, arg_11_0.tweenCallback, arg_11_0)
		arg_11_0._teamView:UnInstallHero(arg_11_0._index)
	else
		local var_11_5 = arg_11_0._teamView.frameTrList[var_11_1._index]
		local var_11_6, var_11_7 = recthelper.getAnchor(var_11_5)

		arg_11_0:setToPos(arg_11_0._go.transform, Vector2(var_11_6, var_11_7), true, arg_11_0.tweenCallback, arg_11_0)

		if var_11_1 ~= arg_11_0 then
			local var_11_8 = arg_11_0._teamView.frameTrList[arg_11_0._index]
			local var_11_9, var_11_10 = recthelper.getAnchor(var_11_8)

			arg_11_0:setToPos(var_11_1._go.transform, Vector2(var_11_9, var_11_10), true, function()
				arg_11_0._teamView:exchangeHeroItem(arg_11_0._index, var_11_1._index)
			end, arg_11_0)
		end
	end
end

function var_0_0.checkDrag(arg_13_0)
	if arg_13_0._heroId and arg_13_0._heroId ~= 0 then
		return false
	end

	return true
end

function var_0_0.findTarget(arg_14_0, arg_14_1)
	for iter_14_0 = 1, arg_14_0._teamView.unLockTeamCnt * 4 do
		local var_14_0 = arg_14_0._teamView.frameTrList[iter_14_0]
		local var_14_1 = arg_14_0._teamView.heroItemList[iter_14_0]
		local var_14_2, var_14_3 = recthelper.getAnchor(var_14_0)
		local var_14_4 = var_14_0.parent
		local var_14_5 = recthelper.screenPosToAnchorPos(arg_14_1, var_14_4)

		if math.abs(var_14_5.x - var_14_2) * 2 < recthelper.getWidth(var_14_0) and math.abs(var_14_5.y - var_14_3) * 2 < recthelper.getHeight(var_14_0) then
			return var_14_1 or nil
		end
	end

	return nil
end

function var_0_0.setToPos(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_3 then
		CommonDragHelper.instance:setGlobalEnabled(false)

		arg_15_0.tweenId = ZProj.TweenHelper.DOAnchorPos(arg_15_1, arg_15_2.x, arg_15_2.y, 0.2, arg_15_4, arg_15_5)
	else
		recthelper.setAnchor(arg_15_1, arg_15_2.x, arg_15_2.y)

		if arg_15_4 then
			arg_15_4(arg_15_5)
		end
	end
end

function var_0_0.tweenCallback(arg_16_0)
	arg_16_0.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

return var_0_0
