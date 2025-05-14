module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpInteract", package.seeall)

local var_0_0 = class("VersionActivity1_5WarmUpInteract", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godragarea = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_dragarea")
	arg_1_0._goguide1 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_guide1")
	arg_1_0._goguide2 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_guide2")
	arg_1_0._imagePhotoMask1 = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask1")
	arg_1_0._imagePhotoMask2 = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask2")
	arg_1_0._imagePhotoMask3 = gohelper.findChildImage(arg_1_0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity146Controller.instance, Activity146Event.DataUpdate, arg_2_0._onDataUpdate, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDragging, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onBeginDrag, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onEndDrag, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity146Controller.instance, Activity146Event.DataUpdate, arg_3_0._onDataUpdate, arg_3_0)
	arg_3_0._drag:RemoveDragListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
end

var_0_0.InteractType = {
	Counting = 2,
	Vertical = 1
}

function var_0_0._onBeginDrag(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.DragFuncMap[arg_4_0._interactType]

	if var_4_0 and var_4_0.onBegin then
		var_4_0.onBegin(arg_4_0, arg_4_1, arg_4_2)
	end
end

function var_0_0._onDragging(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_0.DragFuncMap[arg_5_0._interactType]

	if var_5_0 and var_5_0.onDrag then
		var_5_0.onDrag(arg_5_0, arg_5_1, arg_5_2)
	end
end

function var_0_0._onEndDrag(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_0.DragFuncMap[arg_6_0._interactType]

	if var_6_0 and var_6_0.onEnd then
		var_6_0.onEnd(arg_6_0, arg_6_1, arg_6_2)
	end
end

function var_0_0._onBeginDragVertical(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._isPassEpisode = false
	arg_7_0._dragLengthen = 0

	gohelper.setActive(arg_7_0._goguide1, false)
	gohelper.setActive(arg_7_0._goguide2, false)

	arg_7_0._atticletterOpeningId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_opening)
end

local var_0_1 = 80

function var_0_0._onDraggingVertical(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = Mathf.Abs(arg_8_2.delta.x)
	local var_8_1 = Mathf.Abs(arg_8_2.delta.y)
	local var_8_2 = var_8_0 <= var_8_1

	if not arg_8_0._isPassEpisode and var_8_2 then
		arg_8_0._dragLengthen = arg_8_0._dragLengthen + var_8_1

		if Mathf.Clamp(arg_8_0._dragLengthen / var_0_1, 0, 1) >= 1 then
			arg_8_0._isPassEpisode = true
		end
	end
end

function var_0_0._onEndDragVertical(arg_9_0)
	if arg_9_0._isPassEpisode then
		Activity146Controller.instance:dispatchEvent(Activity146Event.OnEpisodeFinished)
	end

	if arg_9_0._atticletterOpeningId then
		AudioMgr.instance:stopPlayingID(arg_9_0._atticletterOpeningId)

		arg_9_0._atticletterOpeningId = nil
	end
end

local var_0_2 = 3
local var_0_3 = 10

function var_0_0._onBeginDragCounting(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._isPassEpisode = false
	arg_10_0._dragLengthenX = 0
	arg_10_0._dragLengthenY = 0

	gohelper.setActive(arg_10_0._goguide1, false)
	gohelper.setActive(arg_10_0._goguide2, false)
end

local var_0_4 = {
	"1st",
	"2nd",
	"3rd"
}

function var_0_0._onDraggingCounting(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._isPassEpisode then
		local var_11_0 = false

		if Mathf.Abs(arg_11_2.delta.x) > var_0_3 and arg_11_2.delta.x * arg_11_0._dragLengthenX <= 0 then
			var_11_0 = true
		elseif Mathf.Abs(arg_11_2.delta.y) > var_0_3 and arg_11_2.delta.y * arg_11_0._dragLengthenY <= 0 then
			var_11_0 = true
		end

		if var_11_0 then
			arg_11_0._dragLengthenX = arg_11_2.delta.x
			arg_11_0._dragLengthenY = arg_11_2.delta.y
			arg_11_0._dragCount = arg_11_0._dragCount or 0
			arg_11_0._dragCount = arg_11_0._dragCount + 1

			local var_11_1 = var_0_4[arg_11_0._dragCount] or "idle"

			arg_11_0._photoMaskAnim:Play(var_11_1, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_cleaning)

			if arg_11_0._dragCount >= var_0_2 then
				arg_11_0._isPassEpisode = true
			end
		end
	end
end

function var_0_0._onEndDragCounting(arg_12_0)
	if arg_12_0._isPassEpisode then
		Activity146Controller.instance:dispatchEvent(Activity146Event.OnEpisodeFinished)
	end
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_13_0._godragarea)

	local var_13_0 = gohelper.findChild(arg_13_0.viewGO, "Middle/#go_mail2/image_PhotoMask")

	arg_13_0._photoMaskAnim = gohelper.onceAddComponent(var_13_0, typeof(UnityEngine.Animator))
end

function var_0_0._onDataUpdate(arg_14_0)
	local var_14_0 = Activity146Model.instance:getCurSelectedEpisode()

	arg_14_0._interactType = Activity146Config.instance:getEpisodeInteractType(arg_14_0.viewParam.actId, var_14_0)

	arg_14_0._photoMaskAnim:Play("idle", 0, 0)

	arg_14_0._dragCount = 0
end

var_0_0.DragFuncMap = {
	[var_0_0.InteractType.Counting] = {
		onBegin = var_0_0._onBeginDragCounting,
		onDrag = var_0_0._onDraggingCounting,
		onEnd = var_0_0._onEndDragCounting
	},
	[var_0_0.InteractType.Vertical] = {
		onBegin = var_0_0._onBeginDragVertical,
		onDrag = var_0_0._onDraggingVertical,
		onEnd = var_0_0._onEndDragVertical
	}
}

function var_0_0.onClose(arg_15_0)
	if arg_15_0._atticletterOpeningId then
		AudioMgr.instance:stopPlayingID(arg_15_0._atticletterOpeningId)

		arg_15_0._atticletterOpeningId = nil
	end
end

return var_0_0
