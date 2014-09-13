function isPalindrome(text) {
    if (!text) return false;
    if (text.length === 1 || text.length === 0) return true;
    if (text.charAt(0) !== text.charAt(text.length - 1)) return false;
    return isPalindrome(text.substr(1, text.length - 2));
}