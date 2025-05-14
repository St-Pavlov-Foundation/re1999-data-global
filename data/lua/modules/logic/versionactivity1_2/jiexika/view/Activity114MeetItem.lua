module("modules.logic.versionactivity1_2.jiexika.view.Activity114MeetItem", package.seeall)

local var_0_0 = class("Activity114MeetItem", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._gohero = gohelper.findChild(arg_2_0.go, "hero")
	arg_2_0._gonohero = gohelper.findChild(arg_2_0.go, "nohero")
	arg_2_0._simagehero = gohelper.findChildSingleImage(arg_2_0.go, "hero/simage_hero")
	arg_2_0._simagesignature = gohelper.findChildSingleImage(arg_2_0.go, "hero/simage_hero/simage_signature")
	arg_2_0._txtname = gohelper.findChildTextMesh(arg_2_0.go, "hero/info/txt_name")
	arg_2_0._txtnameEn = gohelper.findChildTextMesh(arg_2_0.go, "hero/info/txt_name/txt_nameen")
	arg_2_0._txtcontent = gohelper.findChildTextMesh(arg_2_0.go, "hero/info/#txt_content")
	arg_2_0._simagenohero = gohelper.findChildSingleImage(arg_2_0.go, "nohero/simage_nohero")
	arg_2_0._btnmeet = gohelper.findChildButtonWithAudio(arg_2_0.go, "hero/#btn_meet")
	arg_2_0._gofinish = gohelper.findChild(arg_2_0.go, "hero/#go_finish")
	arg_2_0._txtfinish = gohelper.findChildTextMesh(arg_2_0.go, "hero/#go_finish/cn")
	arg_2_0._gopoint = gohelper.findChild(arg_2_0.go, "hero/point/go_point")
	arg_2_0._txttag = gohelper.findChildTextMesh(arg_2_0.go, "hero/#txt_tag")
	arg_2_0._imagetagicon = gohelper.findChildImage(arg_2_0.go, "hero/#txt_tag/#image_tagicon")
	arg_2_0._imageHero = arg_2_0._simagehero:GetComponent(gohelper.Type_Image)
	arg_2_0._imageNoHero = arg_2_0._simagenohero:GetComponent(gohelper.Type_Image)

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnmeet:AddClickListener(arg_3_0.onMeet, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnmeet:RemoveClickListener()
end

function var_0_0.updateMo(arg_5_0, arg_5_1)
	arg_5_0.mo = arg_5_1

	if arg_5_1 then
		gohelper.setActive(arg_5_0.go, true)

		local var_5_0 = Activity114Model.instance.unLockMeetingDict[arg_5_0.mo.id]

		arg_5_0._simagehero:LoadImage(ResUrl.getAct114MeetIcon("img_role_" .. arg_5_1.id), arg_5_0.onLoadedEnd, arg_5_0)
		arg_5_0._simagenohero:LoadImage(ResUrl.getAct114MeetIcon("img_role_" .. arg_5_1.id), arg_5_0.onLoadedEnd2, arg_5_0)

		if var_5_0 then
			if not Activity114Model.instance:getIsPlayUnLock(Activity114Enum.EventType.Meet, arg_5_0.mo.id) then
				arg_5_0:playUnlockEffect()
			else
				gohelper.setActive(arg_5_0._gohero, true)
				gohelper.setActive(arg_5_0._gonohero, false)
			end

			arg_5_0._txtname.text = arg_5_0.mo.name
			arg_5_0._txtcontent.text = arg_5_0.mo.des
			arg_5_0._txtnameEn.text = arg_5_0.mo.nameEng

			arg_5_0._simagesignature:LoadImage(ResUrl.getSignature(arg_5_0.mo.signature))

			local var_5_1 = Activity114Config.instance:getAttrCo(Activity114Model.instance.id, arg_5_0.mo.tag)

			if var_5_1 then
				arg_5_0._txttag.text = var_5_1.attrName

				UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(arg_5_0._imagetagicon, "icons_" .. var_5_1.attribute)
			end

			gohelper.setActive(arg_5_0._txttag.gameObject, var_5_1)

			local var_5_2 = string.splitToNumber(arg_5_0.mo.events, "#")
			local var_5_3 = var_5_0.times
			local var_5_4 = var_5_3 >= #var_5_2 or var_5_0.isBlock == 1

			if var_5_4 then
				if var_5_0.isBlock == 1 then
					arg_5_0._txtfinish.text = luaLang("versionactivity_1_2_114meetblock")
				else
					arg_5_0._txtfinish.text = luaLang("versionactivity_1_2_114meetfinish")
				end
			end

			gohelper.setActive(arg_5_0._gofinish, var_5_4)
			gohelper.setActive(arg_5_0._btnmeet.gameObject, var_5_0.isBlock ~= 1 and not var_5_4)

			if not arg_5_0.points then
				arg_5_0.points = {}
			end

			for iter_5_0 = 1, #var_5_2 do
				if not arg_5_0.points[iter_5_0] then
					arg_5_0.points[iter_5_0] = arg_5_0:getUserDataTb_()
					arg_5_0.points[iter_5_0].go = gohelper.cloneInPlace(arg_5_0._gopoint, "Point")

					gohelper.setActive(arg_5_0.points[iter_5_0].go, true)
				end

				arg_5_0.points[iter_5_0].event = var_5_2[iter_5_0]

				local var_5_5 = 1

				if var_5_3 < iter_5_0 and var_5_0.isBlock ~= 1 then
					var_5_5 = 1

					local var_5_6 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, var_5_2[iter_5_0])

					if var_5_6.config.isCheckEvent == 1 then
						var_5_5 = var_5_6.config.disposable == 1 and 6 or 7
					end

					if not Activity114Model.instance.unLockEventDict[var_5_2[iter_5_0]] then
						local var_5_7 = string.splitToNumber(var_5_6.config.condition, "#")

						if var_5_7 and #var_5_7 >= 2 and var_5_7[1] == 2 and Activity114Model.instance.serverData.week <= var_5_7[2] then
							var_5_5 = 4

							if iter_5_0 == var_5_3 + 1 then
								gohelper.setActive(arg_5_0._gofinish, true)
								gohelper.setActive(arg_5_0._btnmeet.gameObject, false)
							end
						end
					end
				elseif iter_5_0 < var_5_3 or iter_5_0 == var_5_3 and var_5_0.isBlock ~= 1 then
					var_5_5 = 2
				elseif iter_5_0 == var_5_3 and var_5_0.isBlock == 1 then
					var_5_5 = 3
				elseif var_5_3 < iter_5_0 and var_5_0.isBlock == 1 then
					var_5_5 = 4
				end

				for iter_5_1 = 1, 7 do
					local var_5_8 = gohelper.findChild(arg_5_0.points[iter_5_0].go, "type" .. iter_5_1)

					gohelper.setActive(var_5_8, var_5_5 == iter_5_1)
				end
			end

			local var_5_9 = arg_5_0:isRoundLock()
			local var_5_10 = #var_5_2 >= var_5_3 + 1 and not Activity114Model.instance.unLockEventDict[var_5_2[var_5_3 + 1]]

			ZProj.UGUIHelper.SetGrayscale(arg_5_0._btnmeet.gameObject, var_5_10 or var_5_9)
		else
			gohelper.setActive(arg_5_0._gohero, false)
			gohelper.setActive(arg_5_0._gonohero, true)
		end
	else
		gohelper.setActive(arg_5_0.go, false)
	end
end

function var_0_0.playUnlockEffect(arg_6_0)
	local var_6_0 = SLFramework.AnimatorPlayer.Get(arg_6_0.go)

	var_6_0:Stop()
	var_6_0:Play(UIAnimationName.Unlock, arg_6_0.playUnlockEffectFinish, arg_6_0)
	Activity114Model.instance:setIsPlayUnLock(Activity114Enum.EventType.Meet, arg_6_0.mo.id)
end

function var_0_0.playUnlockEffectFinish(arg_7_0)
	gohelper.setActive(arg_7_0._gonohero, false)
end

function var_0_0.isRoundLock(arg_8_0)
	local var_8_0 = false

	if not string.nilorempty(arg_8_0.mo.banTurn) then
		local var_8_1 = string.splitToNumber(arg_8_0.mo.banTurn, "#")

		if tabletool.indexOf(var_8_1, Activity114Model.instance.serverData.round) then
			var_8_0 = true
		end
	end

	return var_8_0
end

function var_0_0.onLoadedEnd(arg_9_0)
	arg_9_0._imageHero:SetNativeSize()
end

function var_0_0.onLoadedEnd2(arg_10_0)
	arg_10_0._imageNoHero:SetNativeSize()
end

function var_0_0._editableInitView(arg_11_0)
	gohelper.setActive(arg_11_0._gopoint, false)
end

function var_0_0.onMeet(arg_12_0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	if arg_12_0:isRoundLock() then
		GameFacade.showToast(ToastEnum.Act114MeetLock)

		return
	end

	local var_12_0 = Activity114Model.instance.unLockMeetingDict[arg_12_0.mo.id]

	if not Activity114Model.instance.unLockEventDict[arg_12_0.points[var_12_0.times + 1].event] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	Activity114Rpc.instance:meetRequest(Activity114Model.instance.id, arg_12_0.mo.id)
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0.points then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.points) do
			gohelper.destroy(iter_13_1.go)
		end
	end

	arg_13_0._simagehero:UnLoadImage()
	arg_13_0._simagesignature:UnLoadImage()
	arg_13_0._simagenohero:UnLoadImage()

	arg_13_0.go = nil
end

return var_0_0
