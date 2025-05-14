module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5HeroTabItem", package.seeall)

local var_0_0 = class("VersionActivity1_5HeroTabItem", UserDataDispose)

function var_0_0.createItem(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0, arg_1_1)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0.id = arg_2_2.id
	arg_2_0.heroTaskMo = arg_2_2
	arg_2_0.config = arg_2_2.config
	arg_2_0.isUnlock = arg_2_0.heroTaskMo:isUnlock()
	arg_2_0.imageheroicon = gohelper.findChildImage(arg_2_0.go, "#image_heroicon")
	arg_2_0.goLocked = gohelper.findChild(arg_2_0.go, "#go_Locked")
	arg_2_0.txtLocked = gohelper.findChildText(arg_2_0.go, "#go_Locked/#txt_lock")
	arg_2_0.goClickArea = gohelper.findChild(arg_2_0.go, "#go_clickarea")
	arg_2_0.goRedDot = gohelper.findChild(arg_2_0.go, "redPoint")
	arg_2_0.goRedDotRectTr = arg_2_0.goRedDot:GetComponent(gohelper.Type_RectTransform)
	arg_2_0.click = gohelper.getClickWithDefaultAudio(arg_2_0.goClickArea)

	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
	gohelper.setActive(arg_2_0.go, true)
	gohelper.setActive(arg_2_0.goRedDot, true)
	arg_2_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, arg_2_0.refreshHeroIcon, arg_2_0)
	arg_2_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshRedDot, arg_2_0)
	arg_2_0:refreshUI()
end

function var_0_0.onClickSelf(arg_3_0)
	if not arg_3_0.isUnlock then
		GameFacade.showToast(arg_3_0.config.toastId)

		return
	end

	VersionActivity1_5RevivalTaskModel.instance:setSelectHeroTaskId(arg_3_0.id)
end

function var_0_0.refreshUI(arg_4_0)
	arg_4_0:refreshLockUI()
	arg_4_0:refreshHeroIcon()
end

function var_0_0.refreshLockUI(arg_5_0)
	gohelper.setActive(arg_5_0.goLocked, not arg_5_0.isUnlock)

	if not arg_5_0.isUnlock then
		arg_5_0.txtLocked.text = luaLang("rolestoryrewardstate_1")
	end
end

function var_0_0.refreshHeroIcon(arg_6_0)
	gohelper.setActive(arg_6_0.imageheroicon.gameObject, arg_6_0.isUnlock)

	if not arg_6_0.isUnlock then
		return
	end

	local var_6_0 = ""

	if arg_6_0:isExploreTask() then
		var_6_0 = arg_6_0:isSelect() and VersionActivity1_5DungeonEnum.ExploreTabImageSelect or VersionActivity1_5DungeonEnum.ExploreTabImageNotSelect
	else
		var_6_0 = arg_6_0:isSelect() and arg_6_0.config.heroTabIcon .. "_" .. 1 or arg_6_0.config.heroTabIcon .. "_" .. 2
	end

	UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(arg_6_0.imageheroicon, var_6_0)
	arg_6_0:refreshRedDot()
end

function var_0_0.isExploreTask(arg_7_0)
	return arg_7_0.id == VersionActivity1_5DungeonEnum.ExploreTaskId
end

function var_0_0.refreshRedDot(arg_8_0)
	if arg_8_0:isExploreTask() then
		RedDotController.instance:addRedDot(arg_8_0.goRedDot, RedDotEnum.DotNode.V1a5DungeonExploreTask, nil, arg_8_0.refreshExploreRedDot, arg_8_0)
	else
		arg_8_0:createRedDot()

		local var_8_0 = arg_8_0:getHeroTaskRedDotMo()

		gohelper.setActive(arg_8_0.goRedDotIcon, var_8_0 and var_8_0.value > 0)
	end

	local var_8_1 = arg_8_0:isSelect() and VersionActivity1_5DungeonEnum.HeroTaskRedDotAnchor.Normal or VersionActivity1_5DungeonEnum.HeroTaskRedDotAnchor.Lock

	recthelper.setAnchor(arg_8_0.goRedDotRectTr, var_8_1.x, var_8_1.y)
end

function var_0_0.getHeroTaskRedDotMo(arg_9_0)
	if arg_9_0:isExploreTask() then
		return
	end

	local var_9_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a5DungeonHeroTask)

	if not var_9_0 then
		logWarn("not found red dot group mo, id = " .. RedDotEnum.DotNode.V1a5DungeonHeroTask)

		return
	end

	for iter_9_0, iter_9_1 in pairs(var_9_0.infos) do
		if iter_9_1.uid == arg_9_0.id then
			return iter_9_1
		end
	end
end

function var_0_0.createRedDot(arg_10_0)
	if arg_10_0:isExploreTask() then
		return
	end

	if arg_10_0.goRedDotIcon then
		return
	end

	local var_10_0 = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, arg_10_0.goRedDot)

	for iter_10_0, iter_10_1 in pairs(RedDotEnum.Style) do
		local var_10_1 = gohelper.findChild(var_10_0, "type" .. iter_10_1)

		gohelper.setActive(var_10_1, false)

		if iter_10_1 == RedDotEnum.Style.Normal then
			arg_10_0.goRedDotIcon = var_10_1
		end
	end
end

function var_0_0.refreshExploreRedDot(arg_11_0, arg_11_1)
	arg_11_1:defaultRefreshDot()

	if not arg_11_1.show then
		arg_11_1.show = VersionActivity1_5RevivalTaskModel.instance:checkNeedShowElementRedDot()

		arg_11_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.isSelect(arg_12_0)
	return VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() == arg_12_0.id
end

function var_0_0.destroy(arg_13_0)
	arg_13_0.click:RemoveClickListener()
	arg_13_0:__onDispose()
end

return var_0_0
