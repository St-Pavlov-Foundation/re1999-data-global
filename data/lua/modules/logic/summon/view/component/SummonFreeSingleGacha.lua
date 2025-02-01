module("modules.logic.summon.view.component.SummonFreeSingleGacha", package.seeall)

slot0 = class("SummonFreeSingleGacha", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._btnSummonGO = slot1
	slot0._btnSummonGroupGO = nil
	slot0._summonId = slot2
	slot0._canShowFree = SummonConfig.instance:canShowSingleFree(slot0._summonId)

	if not gohelper.isNil(slot0._btnSummonGO) and slot0._canShowFree and not gohelper.isNil(slot0._btnSummonGO.transform.parent) and not gohelper.isNil(slot3.parent) then
		slot0._btnSummonGroupGO = slot3.gameObject

		gohelper.setActive(slot0._btnSummonGroupGO, false)

		slot0._prefabLoader = PrefabInstantiate.Create(slot3.parent.gameObject)

		slot0._prefabLoader:startLoad(ResUrl.getSummonFreeButton(), slot0.handleInstanceLoaded, slot0)
	end
end

function slot0.dispose(slot0)
	logNormal("SummonFreeSingleGacha dispose : " .. tostring(slot0._summonId))

	if slot0._prefabLoader then
		slot0._prefabLoader:onDestroy()
	end

	if slot0._btnFreeSummon then
		slot0._btnFreeSummon:RemoveClickListener()
	end

	slot0:__onDispose()
end

function slot0.handleInstanceLoaded(slot0)
	if slot0._prefabLoader and slot0._summonId then
		slot0._btnFreeSummonGO = slot0._prefabLoader:getInstGO()

		slot0._btnFreeSummonGO.transform:SetSiblingIndex(slot0._btnSummonGroupGO.transform:GetSiblingIndex() + 1)
		slot0:initButton()
		slot0:refreshUI()
	end
end

function slot0.initButton(slot0)
	if slot0._btnFreeSummonGO then
		slot1, slot2 = recthelper.getAnchor(slot0._btnSummonGroupGO.transform)

		recthelper.setAnchor(slot0._btnFreeSummonGO.transform, slot1, slot2)

		slot0._gobtn = gohelper.findChild(slot0._btnFreeSummonGO, "#go_btn")
		slot0._gobanner = gohelper.findChild(slot0._btnFreeSummonGO, "#go_banner")
		slot0._txtbanner = gohelper.findChildText(slot0._btnFreeSummonGO, "#go_banner/#txt_banner")
		slot0._btnFreeSummon = gohelper.findChildButton(slot0._btnFreeSummonGO, "#go_btn/#btn_summonfree")

		slot0._btnFreeSummon:AddClickListener(slot0.onClickSummon, slot0)
		slot0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0.refreshOpenTime, slot0)
	end
end

function slot0.onClickSummon(slot0)
	if slot0._summonId then
		logNormal("SummonFreeSingleGacha send summon 1")
		SummonMainController.instance:sendStartSummon(slot0._summonId, 1, false, true)
	end
end

function slot0.refreshUI(slot0)
	if slot0._summonId and not gohelper.isNil(slot0._btnFreeSummonGO) and not gohelper.isNil(slot0._btnSummonGroupGO) then
		if SummonMainModel.instance:getPoolServerMO(slot0._summonId).haveFree then
			slot0._needCountDown = false

			gohelper.setActive(slot0._btnFreeSummonGO, true)
			gohelper.setActive(slot0._btnSummonGroupGO, false)
			gohelper.setActive(slot0._gobtn, true)

			slot0._txtbanner.text = luaLang("summon_timelimit_free")
		else
			gohelper.setActive(slot0._gobtn, false)
			gohelper.setActive(slot0._btnSummonGroupGO, true)

			if SummonConfig.instance:getSummonPool(slot0._summonId) and slot1.usedFreeCount < slot2.totalFreeCount then
				slot0._needCountDown = true

				gohelper.setActive(slot0._btnFreeSummonGO, true)
			else
				slot0._needCountDown = false

				gohelper.setActive(slot0._btnFreeSummonGO, false)
			end
		end
	end

	slot0:refreshOpenTime()
end

function slot0.refreshOpenTime(slot0)
	if slot0._needCountDown then
		slot2, slot3 = TimeUtil.secondToRoughTime2(ServerTime.getToadyEndTimeStamp(true) - ServerTime.nowInLocal())
		slot0._txtbanner.text = string.format(luaLang("summon_free_after_time"), tostring(slot2) .. tostring(slot3))
	end
end

return slot0
