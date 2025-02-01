module("modules.logic.versionactivity1_2.enter.view.VersionActivity1_2EnterView", package.seeall)

slot0 = class("VersionActivity1_2EnterView", VersionActivityEnterBaseView1_2)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "img_bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityEnter1_2Icon("bg_main"))
end

function slot0.initActivityName(slot0)
	for slot4, slot5 in ipairs(slot0.activityItemList) do
		if slot5.actId == VersionActivity1_2Enum.ActivityId.Season or slot5.actId == VersionActivity1_2Enum.ActivityId.Dungeon then
			slot6 = slot5.activityCo.name
			slot7 = utf8.next_raw(slot6, 1)
			slot5.txtActivityName.text = string.format("<size=65>%s</size>%s", slot6:sub(1, slot7 - 1), slot6:sub(slot7))
		else
			slot5.txtActivityName.text = slot5.activityCo.name
		end
	end
end

function slot0.refreshTimeContainer(slot0, slot1, slot2)
	uv0.super.refreshTimeContainer(slot0, slot1, slot2)
	gohelper.setActive(slot1.txtTime, not slot2)
	gohelper.setActive(slot1.txtRemainTime, slot2)
end

function slot0.onClickActivity1(slot0)
	Activity117Controller.instance:openView(VersionActivity1_2Enum.ActivityId.Trade)
end

function slot0.onClickActivity2(slot0)
	Activity114Controller.instance:openAct114View()
end

function slot0.onClickActivity3(slot0)
	Activity104Controller.instance:openSeasonMainView()
end

function slot0.onClickActivity4(slot0)
	VersionActivity1_2DungeonController.instance:openDungeonView()
end

function slot0.onClickActivity5(slot0)
	YaXianController.instance:openYaXianMapView()
end

function slot0.onClickActivity6(slot0)
	Activity119Controller.instance:openAct119View()
end

function slot0.onRefreshActivity3(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "#go_week"), ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal and Activity104Model.instance:isEnterSpecial(slot1.actId) or false)

	for slot9 = 1, 7 do
		if slot3 then
			if slot9 == 7 then
				gohelper.setActive(gohelper.findChild(slot1.goNormal, string.format("stages/%s", "stageitem" .. slot9)) or gohelper.cloneInPlace(gohelper.findChild(slot1.goNormal, "stages/#go_stageitem"), slot10), Activity104Model.instance:getAct104CurStage(slot1.actId) == 7)
			else
				gohelper.setActive(slot11, true)
			end

			gohelper.setActive(gohelper.findChild(slot11, "full"), slot9 <= slot12)
		else
			gohelper.setActive(slot11, false)
		end
	end
end

function slot0.onRefreshActivity4(slot0, slot1)
	slot0:initActivityDungeonNode(slot1)

	if ActivityHelper.getActivityStatus(VersionActivity1_2Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.NotOnLine or slot2 == ActivityEnum.ActivityStatus.Expired then
		gohelper.setActive(slot0.activityDungeonNodeItem.store_tr.gameObject, false)

		return
	end

	gohelper.setActive(slot0.activityDungeonNodeItem.store_tr.gameObject, true)

	slot0.activityDungeonNodeItem.store_txtCurrencyCount.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.LvHuEMen) and slot3.quantity or 0)
	slot0.activityDungeonNodeItem.store_txtName.text = ActivityConfig.instance:getActivityCo(VersionActivity1_2Enum.ActivityId.DungeonStore).name
	slot6 = slot2 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(slot0.activityDungeonNodeItem.store_goRemainTime, slot6)

	if slot6 then
		slot0.activityDungeonNodeItem.store_txtRemainTime.text = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.DungeonStore] and slot7:getRemainTimeStr2ByEndTime(true) or ""
		slot0.activityDungeonNodeItem.store_image.color = slot0.activityDungeonNodeItem.store_imageOriginColor
		slot0.activityDungeonNodeItem.store_txtCurrencyCount.color = slot0.activityDungeonNodeItem.store_txtCurrencyCountOriginColor
		slot0.activityDungeonNodeItem.store_txtName.color = slot0.activityDungeonNodeItem.store_txtNameOriginColor
	else
		slot0.activityDungeonNodeItem.store_image.color = slot0.activityDungeonNodeItem.lockColor
		slot0.activityDungeonNodeItem.store_txtCurrencyCount.color = slot0.activityDungeonNodeItem.lockColor
		slot0.activityDungeonNodeItem.store_txtName.color = slot0.activityDungeonNodeItem.lockColor
	end

	recthelper.setAnchorY(slot0.activityDungeonNodeItem.store_tr, slot1.showTag and 110 or 90)
end

function slot0.initActivityDungeonNode(slot0, slot1)
	if slot0.activityDungeonNodeItem then
		return
	end

	slot0.activityDungeonNodeItem = slot1
	slot0.activityDungeonNodeItem.store_tr = gohelper.findChild(slot1.rootGo, "#go_store").transform
	slot0.activityDungeonNodeItem.store_txtCurrencyCount = gohelper.findChildText(slot1.rootGo, "#go_store/#txt_currencycount")
	slot0.activityDungeonNodeItem.store_goRemainTime = gohelper.findChild(slot1.rootGo, "#go_store/#go_remaintime")
	slot0.activityDungeonNodeItem.store_txtRemainTime = gohelper.findChildText(slot1.rootGo, "#go_store/#go_remaintime/#txt_remaintime")
	slot0.activityDungeonNodeItem.store_click = gohelper.findChildClick(slot1.rootGo, "#go_store/clickarea/")

	slot0.activityDungeonNodeItem.store_click:AddClickListener(slot0.onClickStore, slot0)

	slot0.activityDungeonNodeItem.store_image = gohelper.findChildImage(slot1.rootGo, "#go_store/#simage_storebg")
	slot0.activityDungeonNodeItem.store_txtName = gohelper.findChildText(slot1.rootGo, "#go_store/storename")
	slot0.activityDungeonNodeItem.store_imageOriginColor = slot0.activityDungeonNodeItem.store_image.color
	slot0.activityDungeonNodeItem.store_txtCurrencyCountOriginColor = slot0.activityDungeonNodeItem.store_txtCurrencyCount.color
	slot0.activityDungeonNodeItem.store_txtNameOriginColor = slot0.activityDungeonNodeItem.store_txtName.color
	slot0.activityDungeonNodeItem.lockColor = GameUtil.parseColor("#3D4B2F")
end

function slot0.onClickStore(slot0)
	VersionActivity1_2EnterController.instance:openActivityStoreView()
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()

	if slot0.activityDungeonNodeItem then
		slot0.activityDungeonNodeItem.store_click:RemoveClickListener()

		slot0.activityDungeonNodeItem = nil
	end
end

return slot0
