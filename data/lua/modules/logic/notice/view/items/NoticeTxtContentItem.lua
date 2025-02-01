module("modules.logic.notice.view.items.NoticeTxtContentItem", package.seeall)

slot0 = class("NoticeTxtContentItem", NoticeContentBaseItem)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0.txtContent = gohelper.findChildText(slot1, "#txt_content", typeof(TMPro.TextMeshProUGUI))
	slot0.goContent = slot0.txtContent.gameObject
	slot0.hyperLinkClick = gohelper.onceAddComponent(slot0.txtContent.gameObject, typeof(ZProj.TMPHyperLinkClick))
end

function slot0.addEventListeners(slot0)
	slot0.hyperLinkClick:SetClickListener(slot0._onClickTextMeshProLink, slot0)
end

function slot0._onClickTextMeshProLink(slot0, slot1)
	logNormal(string.format("on click hyper link, type : %s, link : %s", slot0.mo.linkType, slot0.mo.link))

	if not string.nilorempty(slot0.mo.link) then
		if ViewMgr.instance:getContainer(ViewName.NoticeView) then
			slot2:trackNoticeJump(slot0.mo)
		end

		slot0:jump(slot0.mo.linkType, slot0.mo.link, slot0.mo.link1)
	end
end

function slot0.show(slot0)
	gohelper.setActive(slot0.goContent, true)

	slot0.txtContent.text = slot0:formatTime(slot0.mo.content)
end

function slot0.formatTime(slot0, slot1)
	slot2 = nil

	while true do
		slot5, slot6, slot7, slot8, slot9 = string.find(slot1, NoticeEnum.FindTimePattern, 1)

		if not slot5 then
			break
		end

		slot10, slot11, slot12 = NoticeHelper.getTimeMatchIndexAndTimeTable(slot9)

		if not slot10 then
			slot10 = NoticeEnum.FindTimeType.MD_HM
			slot11 = 1
		end

		table.insert(slot2 or {}, {
			s = slot5,
			e = slot6,
			content = NoticeHelper.buildTimeByType(slot10, slot11, os.date("*t", TimeUtil.getTimeStamp(slot12, tonumber(slot8))))
		})

		slot4 = slot6 + 1
	end

	if not slot2 then
		return slot1
	end

	slot5 = {}
	slot6 = 1

	if slot2 then
		for slot10, slot11 in ipairs(slot2) do
			table.insert(slot5, slot1:sub(slot6, slot11.s - 1))
			table.insert(slot5, slot11.content)

			slot6 = slot11.e + 1
		end
	end

	table.insert(slot5, slot1:sub(slot6))

	return table.concat(slot5)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.goContent, false)
end

return slot0
