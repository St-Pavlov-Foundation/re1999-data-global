module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5HeroGroupBuildingView", package.seeall)

local var_0_0 = class("V1a5HeroGroupBuildingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gototem = gohelper.findChild(arg_1_0.viewGO, "#go_totem")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SwitchReplay, arg_2_0.switchReplay, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.PrefabPath = "ui/viewres/herogroup/herogroupviewtotem.prefab"

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = FightModel.instance:getFightParam().chapterId
	local var_4_1 = false

	if var_4_0 == VersionActivity1_5DungeonEnum.DungeonChapterId.Story1 or var_4_0 == VersionActivity1_5DungeonEnum.DungeonChapterId.Story2 or var_4_0 == VersionActivity1_5DungeonEnum.DungeonChapterId.Story3 or var_4_0 == VersionActivity1_5DungeonEnum.DungeonChapterId.Story4 or var_4_0 == VersionActivity1_5DungeonEnum.DungeonChapterId.ElementFight then
		if not DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId) then
			return
		end

		var_4_1 = true
	end

	if not var_4_1 then
		return
	end

	arg_4_0.loader = PrefabInstantiate.Create(arg_4_0._gototem)

	arg_4_0.loader:startLoad(var_0_0.PrefabPath, arg_4_0.onLoadFinish, arg_4_0)
	VersionActivity1_5DungeonRpc.instance:sendGet140InfosRequest(arg_4_0.onReceiveMsg, arg_4_0)
end

function var_0_0.onLoadFinish(arg_5_0)
	arg_5_0.loadFinishDone = true
	arg_5_0.go = arg_5_0.loader:getInstGO()
	arg_5_0.goPointContainer = gohelper.findChild(arg_5_0.go, "#go_totem/totem/point_container/")
	arg_5_0.pointItemList = arg_5_0:getUserDataTb_()

	table.insert(arg_5_0.pointItemList, arg_5_0:createPointItem(gohelper.findChild(arg_5_0.go, "#go_totem/totem/point_container/#go_pointitem1")))
	table.insert(arg_5_0.pointItemList, arg_5_0:createPointItem(gohelper.findChild(arg_5_0.go, "#go_totem/totem/point_container/#go_pointitem2")))
	table.insert(arg_5_0.pointItemList, arg_5_0:createPointItem(gohelper.findChild(arg_5_0.go, "#go_totem/totem/point_container/#go_pointitem3")))

	arg_5_0._singleBg = gohelper.findChildSingleImage(arg_5_0.go, "#go_totem/totem/bg")
	arg_5_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_5_0.go, "#go_totem/#btn_click")

	arg_5_0._btnclick:AddClickListener(arg_5_0._btnClickOnClick, arg_5_0)
	arg_5_0:refreshPoint()
	arg_5_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, arg_5_0.onUpdateSelectBuild, arg_5_0)
	arg_5_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_5_0.onCloseViewFinish, arg_5_0)
end

function var_0_0.createPointItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getUserDataTb_()

	var_6_0.image = arg_6_1:GetComponent(gohelper.Type_Image)
	var_6_0.effectGo1 = gohelper.findChild(arg_6_1, "#effect_green")
	var_6_0.effectGo2 = gohelper.findChild(arg_6_1, "#effect_yellow")

	return var_6_0
end

function var_0_0.onReceiveMsg(arg_7_0)
	arg_7_0.receiveMsgDone = true

	arg_7_0:refreshPoint()
end

function var_0_0.refreshPoint(arg_8_0)
	if not arg_8_0.receiveMsgDone then
		return
	end

	if not arg_8_0.loadFinishDone then
		return
	end

	gohelper.setActive(arg_8_0._gototem, true)
	gohelper.setActive(arg_8_0.goPointContainer, not arg_8_0.isReplay)

	if not arg_8_0.isReplay then
		for iter_8_0 = 1, VersionActivity1_5DungeonEnum.BuildCount do
			local var_8_0 = VersionActivity1_5BuildModel.instance:getSelectType(iter_8_0)

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(arg_8_0.pointItemList[iter_8_0].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[var_8_0])
		end
	end
end

function var_0_0.switchReplay(arg_9_0, arg_9_1)
	arg_9_0.isReplay = arg_9_1

	arg_9_0:refreshPoint()
end

function var_0_0._btnClickOnClick(arg_10_0)
	if arg_10_0.isReplay then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.pointItemList) do
		gohelper.setActive(iter_10_1.effectGo1, false)
		gohelper.setActive(iter_10_1.effectGo2, false)
	end

	arg_10_0.preSelectTypeList = tabletool.copy(VersionActivity1_5BuildModel.instance:getSelectTypeList())

	ViewMgr.instance:openView(ViewName.V1a5BuildingSkillView)
end

function var_0_0.playPointChangeAnim(arg_11_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_11_0.viewName) then
		return
	end

	if not arg_11_0.preSelectTypeList then
		return
	end

	local var_11_0 = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1 ~= arg_11_0.preSelectTypeList[iter_11_0] then
			local var_11_1 = arg_11_0.pointItemList[iter_11_0]

			if iter_11_1 == VersionActivity1_5DungeonEnum.BuildType.First then
				gohelper.setActive(var_11_1.effectGo1, true)
			else
				gohelper.setActive(var_11_1.effectGo2, true)
			end
		end
	end

	arg_11_0.preSelectTypeList = nil
end

function var_0_0.onCloseViewFinish(arg_12_0)
	arg_12_0:playPointChangeAnim()
end

function var_0_0.onUpdateSelectBuild(arg_13_0)
	arg_13_0:refreshPoint()
	arg_13_0:playPointChangeAnim()
end

function var_0_0.onDestroyView(arg_14_0)
	if arg_14_0._btnclick then
		arg_14_0._btnclick:RemoveClickListener()
	end

	if arg_14_0._singleBg then
		arg_14_0._singleBg:UnLoadImage()
	end

	if arg_14_0.loader then
		arg_14_0.loader:dispose()
	end
end

return var_0_0
