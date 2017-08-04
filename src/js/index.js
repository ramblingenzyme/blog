window.onload = () => {
    const headerElement = document.getElementById('header');
    const headerHeight = headerElement.clientHeight;
    const thresholdHeight = (headerHeight / 3) * 2;

    const isFixedAlready = () => headerElement.classList.contains('fixed');

    const onScroll = (e) => {
        if (window.scrollY >= thresholdHeight) {
            if (!isFixedAlready()) {
                headerElement.classList.add('fixed');
            }
        } else if (window.scrollY === 0 && isFixedAlready()){
            headerElement.classList.remove('fixed');
        }
    }

    window.addEventListener('scroll', onScroll);
}
