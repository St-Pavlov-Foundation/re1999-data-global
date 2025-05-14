module("modules.logic.versionactivity1_2.enter.view.VersionActivity1_2EnterView", package.seeall)

local var_0_0 = class("VersionActivity1_2EnterView", VersionActivityEnterBaseView1_2)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_bg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getVersionActivityEnter1_2Icon("bg_main"))
end

function var_0_0.initActivityName(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.activityItemList) do
		if iter_5_1.actId == VersionActivity1_2Enum.ActivityId.Season or iter_5_1.actId == VersionActivity1_2Enum.ActivityId.Dungeon then
			local var_5_0 = iter_5_1.activityCo.name
			local var_5_1 = utf8.next_raw(var_5_0, 1)
			local var_5_2 = var_5_0:sub(1, var_5_1 - 1)
			local var_5_3 = var_5_0:sub(var_5_1)

			iter_5_1.txtActivityName.text = string.format("<size=65>%s</size>%s", var_5_2, var_5_3)
		else
			iter_5_1.txtActivityName.text = iter_5_1.activityCo.name
		end
	end
end

function var_0_0.refreshTimeContainer(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.super.refreshTimeContainer(arg_6_0, arg_6_1, arg_6_2)
	gohelper.setActive(arg_6_1.txtTime, not arg_6_2)
	gohelper.setActive(arg_6_1.txtRemainTime, arg_6_2)
end

function var_0_0.onClickActivity1(arg_7_0)
	Activity117Controller.instance:openView(VersionActivity1_2Enum.ActivityId.Trade)
end

function var_0_0.onClickActivity2(arg_8_0)
	Activity114Controller.instance:openAct114View()
end

function var_0_0.onClickActivity3(arg_9_0)
	Activity104Controller.instance:openSeasonMainView()
end

function var_0_0.onClickActivity4(arg_10_0)
	VersionActivity1_2DungeonController.instance:openDungeonView()
end

function var_0_0.onClickActivity5(arg_11_0)
	YaXianController.instance:openYaXianMapView()
end

function var_0_0.onClickActivity6(arg_12_0)
	Activity119Controller.instance:openAct119View()
end

function var_0_0.onRefreshActivity3(arg_13_0, arg_13_1)
	local var_13_0 = ActivityHelper.getActivityStatus(arg_13_1.actId) == ActivityEnum.ActivityStatus.Normal
	local var_13_1 = gohelper.findChild(arg_13_1.goNormal, "#go_week")

	gohelper.setActive(var_13_1, var_13_0 and Activity104Model.instance:isEnterSpecial(arg_13_1.actId) or false)

	local var_13_2 = gohelper.findChild(arg_13_1.goNormal, "stages/#go_stageitem")

	for iter_13_0 = 1, 7 do
		local var_13_3 = "stageitem" .. iter_13_0
		local var_13_4 = gohelper.findChild(arg_13_1.goNormal, string.format("stages/%s", var_13_3))

		if var_13_0 then
			local var_13_5 = Activity104Model.instance:getAct104CurStage(arg_13_1.actId)

			var_13_4 = var_13_4 or gohelper.cloneInPlace(var_13_2, var_13_3)

			if iter_13_0 == 7 then
				gohelper.setActive(var_13_4, var_13_5 == 7)
			else
				gohelper.setActive(var_13_4, true)
			end

			local var_13_6 = gohelper.findChild(var_13_4, "full")

			gohelper.setActive(var_13_6, iter_13_0 <= var_13_5)
		else
			gohelper.setActive(var_13_4, false)
		end
	end
end

function var_0_0.onRefreshActivity4(arg_14_0, arg_14_1)
	arg_14_0:initActivityDungeonNode(arg_14_1)

	local var_14_0 = ActivityHelper.getActivityStatus(VersionActivity1_2Enum.ActivityId.DungeonStore)

	if var_14_0 == ActivityEnum.ActivityStatus.NotOnLine or var_14_0 == ActivityEnum.ActivityStatus.Expired then
		gohelper.setActive(arg_14_0.activityDungeonNodeItem.store_tr.gameObject, false)

		return
	end

	gohelper.setActive(arg_14_0.activityDungeonNodeItem.store_tr.gameObject, true)

	local var_14_1 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.LvHuEMen)
	local var_14_2 = var_14_1 and var_14_1.quantity or 0

	arg_14_0.activityDungeonNodeItem.store_txtCurrencyCount.text = GameUtil.numberDisplay(var_14_2)

	local var_14_3 = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.DungeonStore)

	arg_14_0.activityDungeonNodeItem.store_txtName.text = var_14_3.name

	local var_14_4 = var_14_0 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_14_0.activityDungeonNodeItem.store_goRemainTime, var_14_4)

	if var_14_4 then
		local var_14_5 = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.DungeonStore]

		arg_14_0.activityDungeonNodeItem.store_txtRemainTime.text = var_14_5 and var_14_5:getRemainTimeStr2ByEndTime(true) or ""
		arg_14_0.activityDungeonNodeItem.store_image.color = arg_14_0.activityDungeonNodeItem.store_imageOriginColor
		arg_14_0.activityDungeonNodeItem.store_txtCurrencyCount.color = arg_14_0.activityDungeonNodeItem.store_txtCurrencyCountOriginColor
		arg_14_0.activityDungeonNodeItem.store_txtName.color = arg_14_0.activityDungeonNodeItem.store_txtNameOriginColor
	else
		arg_14_0.activityDungeonNodeItem.store_image.color = arg_14_0.activityDungeonNodeItem.lockColor
		arg_14_0.activityDungeonNodeItem.store_txtCurrencyCount.color = arg_14_0.activityDungeonNodeItem.lockColor
		arg_14_0.activityDungeonNodeItem.store_txtName.color = arg_14_0.activityDungeonNodeItem.lockColor
	end

	recthelper.setAnchorY(arg_14_0.activityDungeonNodeItem.store_tr, arg_14_1.showTag and 110 or 90)
end

function var_0_0.initActivityDungeonNode(arg_15_0, arg_15_1)
	if arg_15_0.activityDungeonNodeItem then
		return
	end

	arg_15_0.activityDungeonNodeItem = arg_15_1
	arg_15_0.activityDungeonNodeItem.store_tr = gohelper.findChild(arg_15_1.rootGo, "#go_store").transform
	arg_15_0.activityDungeonNodeItem.store_txtCurrencyCount = gohelper.findChildText(arg_15_1.rootGo, "#go_store/#txt_currencycount")
	arg_15_0.activityDungeonNodeItem.store_goRemainTime = gohelper.findChild(arg_15_1.rootGo, "#go_store/#go_remaintime")
	arg_15_0.activityDungeonNodeItem.store_txtRemainTime = gohelper.findChildText(arg_15_1.rootGo, "#go_store/#go_remaintime/#txt_remaintime")
	arg_15_0.activityDungeonNodeItem.store_click = gohelper.findChildClick(arg_15_1.rootGo, "#go_store/clickarea/")

	arg_15_0.activityDungeonNodeItem.store_click:AddClickListener(arg_15_0.onClickStore, arg_15_0)

	arg_15_0.activityDungeonNodeItem.store_image = gohelper.findChildImage(arg_15_1.rootGo, "#go_store/#simage_storebg")
	arg_15_0.activityDungeonNodeItem.store_txtName = gohelper.findChildText(arg_15_1.rootGo, "#go_store/storename")
	arg_15_0.activityDungeonNodeItem.store_imageOriginColor = arg_15_0.activityDungeonNodeItem.store_image.color
	arg_15_0.activityDungeonNodeItem.store_txtCurrencyCountOriginColor = arg_15_0.activityDungeonNodeItem.store_txtCurrencyCount.color
	arg_15_0.activityDungeonNodeItem.store_txtNameOriginColor = arg_15_0.activityDungeonNodeItem.store_txtName.color
	arg_15_0.activityDungeonNodeItem.lockColor = GameUtil.parseColor("#3D4B2F")
end

function var_0_0.onClickStore(arg_16_0)
	VersionActivity1_2EnterController.instance:openActivityStoreView()
end

function var_0_0.onDestroyView(arg_17_0)
	var_0_0.super.onDestroyView(arg_17_0)
	arg_17_0._simagebg:UnLoadImage()

	if arg_17_0.activityDungeonNodeItem then
		arg_17_0.activityDungeonNodeItem.store_click:RemoveClickListener()

		arg_17_0.activityDungeonNodeItem = nil
	end
end

return var_0_0
