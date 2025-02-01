module("modules.logic.summon.view.luckybag.SummonGetLuckyBagView", package.seeall)

slot0 = class("SummonGetLuckyBagView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "content/#go_collection/txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "content/#go_collection/en")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "content/#go_collection/#simage_icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._bgClick = gohelper.getClick(slot0.viewGO)

	slot0._bgClick:AddClickListener(slot0._onClickBG, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._bgClick:RemoveClickListener()
end

function slot0.onOpen(slot0)
	logNormal("SummonGetLuckyBagView onOpen")
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_wulu_lucky_bag_gain)
	slot0:refreshView()
end

function slot0.onClose(slot0)
end

function slot0.refreshView(slot0)
	if SummonConfig.instance:getLuckyBag(slot0.viewParam.poolId, slot0.viewParam.luckyBagId) then
		slot0._txtname.text = slot3.name
		slot0._txtnameen.text = slot3.nameEn or ""

		slot0._simageicon:LoadImage(ResUrl.getSummonCoverBg(slot3.icon))
	end
end

function slot0._onClickBG(slot0)
	slot0:closeThis()
end

return slot0
