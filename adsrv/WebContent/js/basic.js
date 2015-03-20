//레이어 열기/닫기 키보드 접근성.

jQuery(function($) {
    $('a[href^="#"]').click(function() {
        $($(this).attr('href')).attr('tabindex', '0').show().focus();
    });
    $('.x').click(function() {
        $(this).parent().hide();
    });
});





//상단 메뉴

$(document).ready(
    function() {
        $('.sub').css("display", "none");
        $('nav li').hover(
            function() {
                $('.sub', this).css("display", "block");
                $('ul', this).fadeIn(500);
            },
            function() {
                $('ul', this).fadeOut(10);
            }
        );
        $('.sub li').hover(
            function() {
                $('nav li', this).addClass('a.active');
            }
        );
    }
);


// input file

$(document).on('change', '.btn-file :file', function() {
    var input = $(this),
        numFiles = input.get(0).files ? input.get(0).files.length : 1,
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.trigger('fileselect', [numFiles, label]);
});

$(document).ready(function() {
    $('.btn-file :file').on('fileselect', function(event, numFiles, label) {

        var input = $(this).parents('.input-group').find(':text'),
            log = numFiles > 1 ? numFiles + ' files selected' : label;

        if (input.length) {
            input.val(log);
        } else {
            if (log) alert(log);
        }

    });
});




//모달에 옵션 전달하기 
$("#myModal").modal({
    show: false,
    backdrop: true
});

//모달 가운데로
/*$("#myModal").modal('show').css({
    'margin-top': function() {
        return -($(this).height() / 2);
    },
    'margin-left': function() {
        return -($(this).width() / 2);
    }
})*/


jQuery(document).ready(function ($) {
    'use strict';

    // CENTERED MODALS
    // phase one - store every dialog's height
    $('.modal').each(function () {
        var t = $(this),
            d = t.find('.modal-dialog'),
            fadeClass = (t.is('.fade') ? 'fade' : '');
        // render dialog
        t.removeClass('fade')
            .addClass('invisible')
            .css('display', 'block');
        // read and store dialog height
        d.data('height', d.height());
        // hide dialog again
        t.css('display', '')
            .removeClass('invisible')
            .addClass(fadeClass);
    });
    // phase two - set margin-top on every dialog show
    $('.modal').on('show.bs.modal', function () {
        var t = $(this),
            d = t.find('.modal-dialog'),
            dh = d.data('height'),
            w = $(window).width(),
            h = $(window).height();
        // if it is desktop & dialog is lower than viewport
        // (set your own values)
        if (w > 380 && (dh + 60) < h) {
            d.css('margin-top', Math.round(0.96 * (h - dh) / 2));
        } else {
            d.css('margin-top', '');
        }
    });

});