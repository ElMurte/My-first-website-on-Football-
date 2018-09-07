<script >
    $('.menuHandler').on('click', function() {
        $('a[href="#'+$('.active').attr("id")+'"]').removeClass('current');
        $('.active').removeClass('active').hide();
        $($(this).attr('href')).addClass('active').show();
        $(this).addClass('current');
        return false;
    });

    </script>