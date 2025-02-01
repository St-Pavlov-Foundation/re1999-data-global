module("modules.logic.versionactivity1_2.jiexika.view.Activity114MeetItem", package.seeall)

slot0 = class("Activity114MeetItem", BaseView)

function slot0.ctor(slot0, slot1)
	slot0.go = slot1
end

function slot0.onInitView(slot0)
	slot0._gohero = gohelper.findChild(slot0.go, "hero")
	slot0._gonohero = gohelper.findChild(slot0.go, "nohero")
	slot0._simagehero = gohelper.findChildSingleImage(slot0.go, "hero/simage_hero")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.go, "hero/simage_hero/simage_signature")
	slot0._txtname = gohelper.findChildTextMesh(slot0.go, "hero/info/txt_name")
	slot0._txtnameEn = gohelper.findChildTextMesh(slot0.go, "hero/info/txt_name/txt_nameen")
	slot0._txtcontent = gohelper.findChildTextMesh(slot0.go, "hero/info/#txt_content")
	slot0._simagenohero = gohelper.findChildSingleImage(slot0.go, "nohero/simage_nohero")
	slot0._btnmeet = gohelper.findChildButtonWithAudio(slot0.go, "hero/#btn_meet")
	slot0._gofinish = gohelper.findChild(slot0.go, "hero/#go_finish")
	slot0._txtfinish = gohelper.findChildTextMesh(slot0.go, "hero/#go_finish/cn")
	slot0._gopoint = gohelper.findChild(slot0.go, "hero/point/go_point")
	slot0._txttag = gohelper.findChildTextMesh(slot0.go, "hero/#txt_tag")
	slot0._imagetagicon = gohelper.findChildImage(slot0.go, "hero/#txt_tag/#image_tagicon")
	slot0._imageHero = slot0._simagehero:GetComponent(gohelper.Type_Image)
	slot0._imageNoHero = slot0._simagenohero:GetComponent(gohelper.Type_Image)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmeet:AddClickListener(slot0.onMeet, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmeet:RemoveClickListener()
end

function slot0.updateMo(slot0, slot1)
	slot0.mo = slot1

	if slot1 then
		gohelper.setActive(slot0.go, true)
		slot0._simagehero:LoadImage(ResUrl.getAct114MeetIcon("img_role_" .. slot1.id), slot0.onLoadedEnd, slot0)
		slot0._simagenohero:LoadImage(ResUrl.getAct114MeetIcon("img_role_" .. slot1.id), slot0.onLoadedEnd2, slot0)

		if Activity114Model.instance.unLockMeetingDict[slot0.mo.id] then
			if not Activity114Model.instance:getIsPlayUnLock(Activity114Enum.EventType.Meet, slot0.mo.id) then
				slot0:playUnlockEffect()
			else
				gohelper.setActive(slot0._gohero, true)
				gohelper.setActive(slot0._gonohero, false)
			end

			slot0._txtname.text = slot0.mo.name
			slot0._txtcontent.text = slot0.mo.des
			slot0._txtnameEn.text = slot0.mo.nameEng

			slot0._simagesignature:LoadImage(ResUrl.getSignature(slot0.mo.signature))

			if Activity114Config.instance:getAttrCo(Activity114Model.instance.id, slot0.mo.tag) then
				slot0._txttag.text = slot3.attrName

				UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(slot0._imagetagicon, "icons_" .. slot3.attribute)
			end

			gohelper.setActive(slot0._txttag.gameObject, slot3)

			if slot2.times >= #string.splitToNumber(slot0.mo.events, "#") or slot2.isBlock == 1 then
				if slot2.isBlock == 1 then
					slot0._txtfinish.text = luaLang("versionactivity_1_2_114meetblock")
				else
					slot0._txtfinish.text = luaLang("versionactivity_1_2_114meetfinish")
				end
			end

			gohelper.setActive(slot0._gofinish, slot6)
			gohelper.setActive(slot0._btnmeet.gameObject, slot2.isBlock ~= 1 and not slot6)

			if not slot0.points then
				slot0.points = {}
			end

			for slot10 = 1, #slot4 do
				if not slot0.points[slot10] then
					slot0.points[slot10] = slot0:getUserDataTb_()
					slot0.points[slot10].go = gohelper.cloneInPlace(slot0._gopoint, "Point")

					gohelper.setActive(slot0.points[slot10].go, true)
				end

				slot0.points[slot10].event = slot4[slot10]
				slot11 = 1

				if slot5 < slot10 and slot2.isBlock ~= 1 then
					slot11 = 1

					if Activity114Config.instance:getEventCoById(Activity114Model.instance.id, slot4[slot10]).config.isCheckEvent == 1 then
						slot11 = slot12.config.disposable == 1 and 6 or 7
					end

					if not Activity114Model.instance.unLockEventDict[slot4[slot10]] and string.splitToNumber(slot12.config.condition, "#") and #slot13 >= 2 and slot13[1] == 2 and Activity114Model.instance.serverData.week <= slot13[2] then
						slot11 = 4

						if slot10 == slot5 + 1 then
							gohelper.setActive(slot0._gofinish, true)
							gohelper.setActive(slot0._btnmeet.gameObject, false)
						end
					end
				elseif slot10 < slot5 or slot10 == slot5 and slot2.isBlock ~= 1 then
					slot11 = 2
				elseif slot10 == slot5 and slot2.isBlock == 1 then
					slot11 = 3
				elseif slot5 < slot10 and slot2.isBlock == 1 then
					slot11 = 4
				end

				for slot15 = 1, 7 do
					gohelper.setActive(gohelper.findChild(slot0.points[slot10].go, "type" .. slot15), slot11 == slot15)
				end
			end

			ZProj.UGUIHelper.SetGrayscale(slot0._btnmeet.gameObject, #slot4 >= slot5 + 1 and not Activity114Model.instance.unLockEventDict[slot4[slot5 + 1]] or slot0:isRoundLock())
		else
			gohelper.setActive(slot0._gohero, false)
			gohelper.setActive(slot0._gonohero, true)
		end
	else
		gohelper.setActive(slot0.go, false)
	end
end

function slot0.playUnlockEffect(slot0)
	slot1 = SLFramework.AnimatorPlayer.Get(slot0.go)

	slot1:Stop()
	slot1:Play(UIAnimationName.Unlock, slot0.playUnlockEffectFinish, slot0)
	Activity114Model.instance:setIsPlayUnLock(Activity114Enum.EventType.Meet, slot0.mo.id)
end

function slot0.playUnlockEffectFinish(slot0)
	gohelper.setActive(slot0._gonohero, false)
end

function slot0.isRoundLock(slot0)
	slot1 = false

	if not string.nilorempty(slot0.mo.banTurn) and tabletool.indexOf(string.splitToNumber(slot0.mo.banTurn, "#"), Activity114Model.instance.serverData.round) then
		slot1 = true
	end

	return slot1
end

function slot0.onLoadedEnd(slot0)
	slot0._imageHero:SetNativeSize()
end

function slot0.onLoadedEnd2(slot0)
	slot0._imageNoHero:SetNativeSize()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gopoint, false)
end

function slot0.onMeet(slot0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	if slot0:isRoundLock() then
		GameFacade.showToast(ToastEnum.Act114MeetLock)

		return
	end

	if not Activity114Model.instance.unLockEventDict[slot0.points[Activity114Model.instance.unLockMeetingDict[slot0.mo.id].times + 1].event] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	Activity114Rpc.instance:meetRequest(Activity114Model.instance.id, slot0.mo.id)
end

function slot0.onDestroyView(slot0)
	if slot0.points then
		for slot4, slot5 in pairs(slot0.points) do
			gohelper.destroy(slot5.go)
		end
	end

	slot0._simagehero:UnLoadImage()
	slot0._simagesignature:UnLoadImage()
	slot0._simagenohero:UnLoadImage()

	slot0.go = nil
end

return slot0
